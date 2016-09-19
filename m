From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 19 Sep 2016 15:16:08 -0700
Subject: [Intel-wired-lan] [PATCH] igb: mark
	igb_rxnfc_write_vlan_prio_filter() static
In-Reply-To: <1474188628-420-1-git-send-email-baoyou.xie@linaro.org>
References: <1474188628-420-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1474323368.28223.49.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, 2016-09-18 at 16:50 +0800, Baoyou Xie wrote:
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

Already fixed, see?http://patchwork.ozlabs.org/patch/661904/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160919/47a2bd31/attachment.asc>
