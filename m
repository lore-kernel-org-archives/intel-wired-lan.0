From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 1 May 2018 21:24:26 +0000
Subject: [Intel-wired-lan] [PATCH 3/6] fm10k: use variadic arguments to
 fm10k_add_stat_strings
In-Reply-To: <20180412181559.4343-3-jacob.e.keller@intel.com>
References: <20180412181559.4343-1-jacob.e.keller@intel.com>
 <20180412181559.4343-3-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E8294D4F0@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 3/6] fm10k: use variadic arguments to
> fm10k_add_stat_strings
> 
> Instead of using a fixed prefix string we setup before each call to
> fm10k_add_stat_strings, modify the helper to take variadic arguments and
> pass them to vsnprintf. This requires changing the fm10k_stat strings to
> take % format specifiers where necessary, but the resulting code is much
> simpler.
> 
> Change-Id: I8055adeae0d63c227024c007c2ff51d0ee495238
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Title: use variadic arguments to fm10k_add_stat_strings
> Change-type: ImplementationChange
> Reviewed-on: https://git-amr-1.devtools.intel.com/gerrit/198022
> Tested-by: nosbuild <nosbuild@intel.com>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

