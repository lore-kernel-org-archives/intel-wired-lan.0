From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 7 Sep 2017 22:21:02 +0000
Subject: [Intel-wired-lan] [next-queue v3] i40e/i40evf: organize and
 re-number feature flags
In-Reply-To: <20170901205407.41800-1-jeffrey.t.kirsher@intel.com>
References: <20170901205407.41800-1-jeffrey.t.kirsher@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5882A9EE9F@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Kirsher, Jeffrey T
> Sent: Friday, September 01, 2017 1:54 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [next-queue v3] i40e/i40evf: organize and re-number feature flags
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Now that we've reduced the number of flags, organize similar flags
> together and re-number them accordingly.
> 
> Since we don't yet have more than 32 flags, we'll use a u32 for both the
> hw_features and flag field. Should we gain more flags in the future, we
> may need to convert to a u64 or separate flags out into two fields.
> 
> One alternative approach considered, but not implemented here, was to
> use an enumeration for the flag variables, and create a macro
> I40E_FLAG() which used string concatenation to generate BIT_ULL values.
> This has the advantage of making the actual bit values compile-time
> dynamic so that we do not need to worry about matching the order to the
> bit value. However, this does produce a high level of code churn, and
> makes it more difficult to read a dumped flags value when debugging.
> 
> v3: rebased patch based on the current dev-queue branch
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I8653fff69453cd547d6fe98d29dfa9d8710387d1
> ---

This version has a u64 instead of u32 for the flags variable, and that causes cmpxchg warnings. I sent a v4 to resolve this.

Thanks,
Jake
