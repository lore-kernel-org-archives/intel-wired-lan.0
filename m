From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 18 Sep 2017 17:23:28 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: prefer %s and __func__
	for	diagnostic prints
In-Reply-To: <20170811181437.30509-1-jacob.e.keller@intel.com>
References: <20170811181437.30509-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64AF680E@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Jacob Keller
> Sent: Friday, August 11, 2017 11:15 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH] fm10k: prefer %s and __func__ for diagnostic
> prints
> 
> Don't hardcode the function names in the diagnostic output when these
> reset related routines fail. Instead, use %s and __func__ so that future
> refactors don't need to change the print outs.
> 
> Additionally, while we are here, add missing function header comments
> for the new reset_prepare and reset_done function handlers.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

