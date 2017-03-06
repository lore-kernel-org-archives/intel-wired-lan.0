From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Sun, 05 Mar 2017 17:10:51 -0800
Subject: [Intel-wired-lan] [next PATCH S61 05/10] i40e: Add support for
 25G in ethtool
In-Reply-To: <1487721348-25617-6-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
 <1487721348-25617-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1488762651.3477.8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2017-02-21 at 15:55 -0800, Bimmy Pujari wrote:
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> Implemented functions for the updated get and set commands
> in ethtool: ETHTOOL_GLINKSETTING and ETHTOOL_SLINKSETTINGS.
> These new commands will replace the existing functionality
> of ETHTOOL_GSET and ETHTOOL_SSET, which have been deprecated.
> 
> Macros for 25G support were added to the include files at the
> same time as the new ethtool commands. So, 25G support has
> been implemented in the new functions.
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Change-ID: I3824ed616cf92bc8bdce3e976277a0cf94d0cd35
> ---
> Testing Hints: The kernel macros required by this patch are
> available in Linux kernels after 4.7. Also, the 25G macros have
> been back ported into RHEL7.3. This functionality was added in
> ethtool version 4.5.
> 
> ?drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 583
> +++++++++++++++++++++++++
> ?1 file changed, 583 insertions(+)

This patch does not apply and conflicts with changes already in the
dev-queue.  Please review the changes and resubmit this patch only.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170305/b5e4fad6/attachment.asc>
