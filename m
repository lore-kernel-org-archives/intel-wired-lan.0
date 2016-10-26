From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Oct 2016 22:13:25 +0000
Subject: [Intel-wired-lan] [next PATCH S51-V2 5/8] i40e: avoid
	duplicate	private flags definitions
In-Reply-To: <1477436933-13679-6-git-send-email-bimmy.pujari@intel.com>
References: <1477436933-13679-1-git-send-email-bimmy.pujari@intel.com>
 <1477436933-13679-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA292AE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, October 25, 2016 4:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S51-V2 5/8] i40e: avoid duplicate
> private flags definitions
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Separate the global private flags and the regular private flags per interface
> into two arrays. Future additions of private flags will not need to be
> duplicated which may lead to buggy code. Also rename
> "i40e_priv_flags_strings_gl" to "i40e_gl_priv_flags_strings" for clarity, as it
> reads more naturally.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I68caef3c9954eb7da342d7f9d20f2873186f2758
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 42 +++++++++++------------
> ---
>  1 file changed, 17 insertions(+), 25 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


