From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Sun, 25 Sep 2016 15:22:09 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: mark symbols static where
	possible
In-Reply-To: <1474783438-7278-1-git-send-email-baoyou.xie@linaro.org>
References: <1474783438-7278-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1474842129.2751.4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, 2016-09-25 at 14:03 +0800, Baoyou Xie wrote:
> We get 2 warnings when building kernel with W=1:
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2128:5: warning: no
> previous prototype for 'ixgbe_led_on_t_x550em' [-Wmissing-prototypes]
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2150:5: warning: no
> previous prototype for 'ixgbe_led_off_t_x550em' [-Wmissing-prototypes]
> 
> In fact, these two functions are only used in the file in which they are
> declared and don't need a declaration, but can be made static.
> so this patch marks these functions with 'static'.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 4 ++--
> ?1 file changed, 2 insertions(+), 2 deletions(-)


This has been fixed and pushed upstream, why do you keep submitting this?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160925/ccc401a7/attachment.asc>
