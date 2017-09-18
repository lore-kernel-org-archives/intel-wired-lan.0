From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 18 Sep 2017 17:24:13 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: fix mis-ordered parameters
	in	declaration for .ndo_set_vf_bw
In-Reply-To: <20170811181458.30776-1-jacob.e.keller@intel.com>
References: <20170811181458.30776-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64AF6827@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH] fm10k: fix mis-ordered parameters in
> declaration for .ndo_set_vf_bw
> 
> We've had support for setting both a minimum and maximum bandwidth via
> .ndo_set_vf_bw since commit 883a9ccbae56 ("fm10k: Add support for SR-IOV
> to driver", 2014-09-20).
> 
> Likely because we do not support minimum rates, the declaration
> mis-ordered the "unused" parameter, which causes warnings when analyzed
> with cppcheck.
> 
> Fix this warning by properly declaring the min_rate and max_rate
> variables in the declaration and definition (rather than using
> "unused"). Also rename "rate" to max_rate so as to clarify that we only
> support setting the maximum rate.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Tested-by: Krishneil Singh  <krishneil.k.singh@intel.com>

