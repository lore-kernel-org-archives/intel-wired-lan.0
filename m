From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 25 Aug 2020 19:27:33 +0200
Subject: [Intel-wired-lan] [PATCH net v3 0/3] Avoid premature Rx buffer
 reuse for XDP_REDIRECT
Message-ID: <20200825172736.27318-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Intel NICs have a recycle mechanism. The main idea is that a page is
split into two parts. One part is owned by the driver, one part might
be owned by someone else, such as the stack.

The page recycle code, incorrectly, relied on that a page fragment
could not be freed inside xdp_do_redirect(), e.g. a redirect to a
devmap where the ndo_xdp_xmit() implementation would transmit and free
the frame, or xskmap where the frame would be copied to userspace and
freed.

This assumption leads to that page fragments that are used by the
stack/XDP redirect can be reused and overwritten.

To avoid this, store the page count prior invoking
xdp_do_redirect(). The affected drivers are ixgbe, ice, and i40e.

An example how things might go wrong:

t0: Page is allocated, and put on the Rx ring
              +---------------
used by NIC ->| upper buffer
(rx_buffer)   +---------------
              | lower buffer
              +---------------
  page count  == USHRT_MAX
  rx_buffer->pagecnt_bias == USHRT_MAX

t1: Buffer is received, and passed to the stack (e.g.)
              +---------------
              | upper buff (skb)
              +---------------
used by NIC ->| lower buffer
(rx_buffer)   +---------------
  page count  == USHRT_MAX
  rx_buffer->pagecnt_bias == USHRT_MAX - 1

t2: Buffer is received, and redirected
              +---------------
              | upper buff (skb)
              +---------------
used by NIC ->| lower buffer
(rx_buffer)   +---------------

Now, prior calling xdp_do_redirect():
  page count  == USHRT_MAX
  rx_buffer->pagecnt_bias == USHRT_MAX - 2

This means that buffer *cannot* be flipped/reused, because the skb is
still using it.

The problem arises when xdp_do_redirect() actually frees the
segment. Then we get:
  page count  == USHRT_MAX - 1
  rx_buffer->pagecnt_bias == USHRT_MAX - 2

From a recycle perspective, the buffer can be flipped and reused,
which means that the skb data area is passed to the Rx HW ring!

To work around this, the page count is stored prior calling
xdp_do_redirect().

Note that this is not optimal, since the NIC could actually reuse the
"lower buffer" again. However, then we need to track whether
XDP_REDIRECT consumed the buffer or not. This scenario is very rare,
and tracking consumtion status would introduce more complexity.

A big thanks to Li RongQing from Baidu for having patience with me
understanding that there was a bug. I would have given up much
earlier! :-)


Cheers,
Bj?rn

v2->v3: Fixed kdoc for i40e/ice. (Jakub)
v1->v2: Removed page count function into get Rx buffer function, and
        changed scope of automatic variable. (Maciej)


Bj?rn T?pel (3):
  i40e: avoid premature Rx buffer reuse
  ixgbe: avoid premature Rx buffer reuse
  ice: avoid premature Rx buffer reuse

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 27 ++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 30 +++++++++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 24 ++++++++++-----
 3 files changed, 58 insertions(+), 23 deletions(-)


base-commit: 99408c422d336db32bfab5cbebc10038a70cf7d2
-- 
2.25.1

