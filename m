From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 1 May 2018 21:23:57 +0000
Subject: [Intel-wired-lan] [PATCH 2/6] fm10k: reduce duplicate
 fm10k_stat macro code
In-Reply-To: <20180412181559.4343-2-jacob.e.keller@intel.com>
References: <20180412181559.4343-1-jacob.e.keller@intel.com>
 <20180412181559.4343-2-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E8294D4DD@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Jacob Keller
> Sent: Thursday, April 12, 2018 11:16 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH 2/6] fm10k: reduce duplicate fm10k_stat
> macro code
> 
> Share some of the code for setting up fm10k_stat macros by implementing
> an FM10K_STAT_FIELDS macro which we can use when setting up the type
> specific macros.
> 
> Change-Id: Ifeedfafa4707cbeb4fac818ed6672eb1db268e1a
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Title: reduce duplicate fm10k_stat macro code
> Change-type: ImplementationChange
> Reviewed-on: https://git-amr-1.devtools.intel.com/gerrit/198021
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

