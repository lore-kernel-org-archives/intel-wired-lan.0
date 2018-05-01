From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 1 May 2018 21:24:59 +0000
Subject: [Intel-wired-lan] [PATCH 4/6] fm10k: use macro to avoid passing
 the array and size separately
In-Reply-To: <20180412181559.4343-4-jacob.e.keller@intel.com>
References: <20180412181559.4343-1-jacob.e.keller@intel.com>
 <20180412181559.4343-4-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E8294D503@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 4/6] fm10k: use macro to avoid passing the
> array and size separately
> 
> Avoid potential bugs with fm10k_add_stat_strings and
> fm10k_add_ethtool_stats by using a macro to calculate the ARRAY_SIZE
> when passing. This helps ensure that the size is always correct.
> 
> Note that it assumes we only pass static const fm10k_stat arrays, and
> that evaluation of the argument won't have side effects.
> 
> Change-Id: Id9396eef12cbab51a2559db80782e33fb20df274
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Title: use macro to avoid passing the array and size separately
> Change-type: ImplementationChange
> Reviewed-on: https://git-amr-1.devtools.intel.com/gerrit/198023
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

