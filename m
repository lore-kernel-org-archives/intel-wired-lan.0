From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 07 Jan 2016 22:35:40 -0800
Subject: [Intel-wired-lan] [next PATCH] i40e: add priv flag for
 automatic rule eviction
In-Reply-To: <1451959393-4771-1-git-send-email-deepthi.kavalur@intel.com>
References: <1451959393-4771-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1452234940.19358.27.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-01-04 at 18:03 -0800, Deepthi Kavalur wrote:
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> The X722 can support automatic rule eviction for automatically added
> flow director rules.? Feature is (should be) disabled by default.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
> ?drivers/net/ethernet/intel/i40e/i40e.h???????? | 1 +
> ?drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 9 +++++++++
> ?drivers/net/ethernet/intel/i40e/i40e_main.c??? | 2 ++
> ?drivers/net/ethernet/intel/i40e/i40e_txrx.c??? | 6 ++++--
> ?drivers/net/ethernet/intel/i40e/i40e_type.h??? | 4 ++++
> ?5 files changed, 20 insertions(+), 2 deletions(-)

This does not apply to cleanly to my dev-queue branch. ?Please submit
an updated patch to applies cleanly, please.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160107/7ada0764/attachment.asc>
