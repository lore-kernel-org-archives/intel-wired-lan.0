From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 20 Jun 2019 00:13:07 +0000
Subject: [Intel-wired-lan] [PATCH v2] e1000e: PCIm function state support
In-Reply-To: <20190613050649.41402-1-vitaly.lifshits@intel.com>
References: <20190613050649.41402-1-vitaly.lifshits@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970B075F@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2019-06-13 at 08:06 +0300, Vitaly Lifshits wrote:
> Due to commit: 5d8682588605 ("[misc] mei: me: allow runtime
> 			pm for platform with D0i3")
> When disconnecting the cable and reconnecting it the NIC
> enters DMoff state. This caused wrong link indication
> and duplex mismatch. This bug is described in:
> https://bugzilla.redhat.com/show_bug.cgi?id=1689436
> 
> Checking PCIm function state and performing PHY reset after a
> timeout in watchdog task solves this issue.
> 
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> ---
> 
> V2: Fixed typos in commit massage
> ---
>  drivers/net/ethernet/intel/e1000e/defines.h |  3 +++
>  drivers/net/ethernet/intel/e1000e/netdev.c  | 18 +++++++++++++++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
