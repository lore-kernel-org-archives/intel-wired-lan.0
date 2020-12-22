From: Andre Guedes <andre.guedes@intel.com>
Date: Mon, 21 Dec 2020 17:12:57 -0800
Subject: [Intel-wired-lan] [PATCH 02/10] igc: Refactor igc_xdp_run_prog()
In-Reply-To: <20201221224512.GA2943@ranger.igk.intel.com>
References: <20201217202415.77891-1-andre.guedes@intel.com>
 <20201217202415.77891-3-andre.guedes@intel.com>
 <20201221224512.GA2943@ranger.igk.intel.com>
Message-ID: <160859957744.45139.11273115849915966927@bgdudka-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Quoting Maciej Fijalkowski (2020-12-21 14:45:12)
> On Thu, Dec 17, 2020 at 12:24:07PM -0800, Andre Guedes wrote:
> > This patch refactors igc_xdp_run_prog() helper, preparing the code for
> 
> s/This patch refactors/Refactor
> 
> to follow the guideline of using the imperative mood in commit msgs.
> 
> > AF_XDP zero-copy support which is added by upcoming patches.
> > 
> > With AF_XDP zero-copy support, igc_poll() will have a dedicated path
> > when the rx ring has zero-copy is enabled. To avoid code duplication as
> 
> The end of this sentence is a bit bogus.
> 
> What about:
> 
> With AF_XDP zero-copy support, igc_poll() will have a dedicated path
> when rx ring's memory model is MEM_TYPE_XSK_BUFF_POOL.
> 
> ?
> 
> > much as possible, this patch encapsulates the code specific to handling
> 
> s/this patch encapsulates/encapsulate
> 
> git grep "This patch" Documentation/process/submitting-patches.rst
> 
> as a refresher :)
> 

Thanks for the suggestions above. I'll fix all commit messages in the v2.
