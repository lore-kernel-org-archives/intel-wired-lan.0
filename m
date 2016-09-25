From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Sun, 25 Sep 2016 15:23:37 -0700
Subject: [Intel-wired-lan] [PATCH] igb: mark
	igb_rxnfc_write_vlan_prio_filter() static
In-Reply-To: <1474783558-7384-1-git-send-email-baoyou.xie@linaro.org>
References: <1474783558-7384-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1474842217.2751.6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, 2016-09-25 at 14:05 +0800, Baoyou Xie wrote:
> We get 1 warning when building kernel with W=1:
> drivers/net/ethernet/intel/igb/igb_ethtool.c:2707:5: warning: no previous
> prototype for 'igb_rxnfc_write_vlan_prio_filter' [-Wmissing-prototypes]
> 
> In fact, this function is only used in the file in which it is
> declared and don't need a declaration, but can be made static.
> so this patch marks this function with 'static'.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
> ?drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ++--
> ?1 file changed, 2 insertions(+), 2 deletions(-)

This has been fixed as well, and there is already a patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160925/f49e25c3/attachment.asc>
