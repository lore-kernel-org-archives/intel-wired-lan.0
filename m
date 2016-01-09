From: Kavalur, Deepthi <deepthi.kavalur@intel.com>
Date: Sat, 9 Jan 2016 01:52:18 +0000
Subject: [Intel-wired-lan] [next PATCH] i40e: add priv flag for
 automatic rule eviction
In-Reply-To: <1452234940.19358.27.camel@intel.com>
References: <1451959393-4771-1-git-send-email-deepthi.kavalur@intel.com>
 <1452234940.19358.27.camel@intel.com>
Message-ID: <D2CB76B6BECC8945A41B7D7368481CE6010A1A1F@ORSMSX111.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Submitted v2 of this patch. Thank you.

-----Original Message-----
From: Kirsher, Jeffrey T 
Sent: Thursday, January 7, 2016 10:36 PM
To: Kavalur, Deepthi <deepthi.kavalur@intel.com>; intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] [next PATCH] i40e: add priv flag for automatic rule eviction

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

This does not apply to cleanly to my dev-queue branch. ?Please submit an updated patch to applies cleanly, please.
