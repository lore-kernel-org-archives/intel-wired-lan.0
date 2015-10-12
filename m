From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Mon, 12 Oct 2015 17:31:15 +0000
Subject: [Intel-wired-lan] [next-queue 2/8] ixgbe: fix a typo in
	the	configuration help menu
In-Reply-To: <1444629588-29933-2-git-send-email-sakiwit@gmail.com>
References: <1444629588-29933-1-git-send-email-sakiwit@gmail.com>
 <1444629588-29933-2-git-send-email-sakiwit@gmail.com>
Message-ID: <D74D5B9C-8339-495D-B772-D3A601BCA879@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

J?an Sacren <sakiwit@gmail.com> wrote:

> From: Jean Sacren <sakiwit@gmail.com>
> 
> 'warming' should be 'warning'. Fix it so that the pertinent text in
> Direct Cache Access (DCA) Support menu would deliver the intended
> semantics.
> 
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
> drivers/net/ethernet/intel/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
> index 1268a182d1a2..de699cd628f4 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -215,7 +215,7 @@ config IXGBE_DCA
> 	depends on IXGBE && DCA && !(IXGBE=y && DCA=m)
> 	---help---
> 	  Say Y here if you want to use Direct Cache Access (DCA) in the
> -	  driver.  DCA is a method for warming the CPU cache before data
> +	  driver.  DCA is a method for warning the CPU cache before data
> 	  is used, with the intent of lessening the impact of cache misses.
> 
> config IXGBE_DCB

NAK. This is not a typo! Caches are "warmed" by getting data into them that is expected to be accessed soon.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151012/adcc398b/attachment.asc>
