From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 13 Jan 2021 08:19:33 -0800
Subject: [Intel-wired-lan] [PATCH][v2] igb: avoid premature Rx buffer
 reuse
In-Reply-To: <1610538220-25980-1-git-send-email-lirongqing@baidu.com>
References: <1610538220-25980-1-git-send-email-lirongqing@baidu.com>
Message-ID: <CAKgT0Udh8_m=MpDLsWfAeWh2uvFq4ksJ=00e8zMB-v7=P4XLMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 13, 2021 at 3:47 AM Li RongQing <lirongqing@baidu.com> wrote:
>
> Igb needs a similar fix as commit 75aab4e10ae6a ("i40e: avoid
> premature Rx buffer reuse")
>
> The page recycle code, incorrectly, relied on that a page fragment
> could not be freed inside xdp_do_redirect(). This assumption leads to
> that page fragments that are used by the stack/XDP redirect can be
> reused and overwritten.
>
> To avoid this, store the page count prior invoking xdp_do_redirect().
>
> Longer explanation:
>
> Intel NICs have a recycle mechanism. The main idea is that a page is
> split into two parts. One part is owned by the driver, one part might
> be owned by someone else, such as the stack.
>
> t0: Page is allocated, and put on the Rx ring
>               +---------------
> used by NIC ->| upper buffer
> (rx_buffer)   +---------------
>               | lower buffer
>               +---------------
>   page count  == USHRT_MAX
>   rx_buffer->pagecnt_bias == USHRT_MAX
>
> t1: Buffer is received, and passed to the stack (e.g.)
>               +---------------
>               | upper buff (skb)
>               +---------------
> used by NIC ->| lower buffer
> (rx_buffer)   +---------------
>   page count  == USHRT_MAX
>   rx_buffer->pagecnt_bias == USHRT_MAX - 1
>
> t2: Buffer is received, and redirected
>               +---------------
>               | upper buff (skb)
>               +---------------
> used by NIC ->| lower buffer
> (rx_buffer)   +---------------
>
> Now, prior calling xdp_do_redirect():
>   page count  == USHRT_MAX
>   rx_buffer->pagecnt_bias == USHRT_MAX - 2
>
> This means that buffer *cannot* be flipped/reused, because the skb is
> still using it.
>
> The problem arises when xdp_do_redirect() actually frees the
> segment. Then we get:
>   page count  == USHRT_MAX - 1
>   rx_buffer->pagecnt_bias == USHRT_MAX - 2
>
> From a recycle perspective, the buffer can be flipped and reused,
> which means that the skb data area is passed to the Rx HW ring!
>
> To work around this, the page count is stored prior calling
> xdp_do_redirect().
>
> Fixes: 9cbc948b5a20 ("igb: add XDP support")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Looks good.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
