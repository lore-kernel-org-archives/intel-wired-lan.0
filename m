From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 10 Nov 2015 09:27:08 -0800
Subject: [Intel-wired-lan] [PATCH v3 1/6] i40e: Remove CONFIG_I40E_VXLAN
In-Reply-To: <1447136740-77107-1-git-send-email-anjali.singhai@intel.com>
References: <1447136740-77107-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <1447176428.3150.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-11-09 at 22:25 -0800, Anjali Singhai Jain wrote:
> If the kernel flag CONFIG_VXLAN is true or CONFIG_VXLAN_MODULE is
> true,
> enable VXLAN offload in the driver.
> 
> v2: Fix bisection error for this patch series.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
> ?drivers/net/ethernet/intel/Kconfig????????? | 11 -----------
> ?drivers/net/ethernet/intel/i40e/i40e.h????? |? 4 ----
> ?drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++----------
> ?3 files changed, 4 insertions(+), 25 deletions(-)

Does not apply cleanly (probably due to Josh's changes in his last
series). ?Please update your series to my lastest tree and re-submit.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151110/583afcad/attachment.asc>
