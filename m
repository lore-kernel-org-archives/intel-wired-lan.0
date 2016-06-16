From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 16 Jun 2016 17:43:18 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe: napi_poll must return the
	work done
In-Reply-To: <CAHdzE-8V8o9sg9xmiJ9J0G3u=k6K-fHQssb5v09TPJvN2N=a1Q@mail.gmail.com>
References: <37ccedd746ed932b9d73eff592f324f2a3fc6c6f.1465995724.git.pabeni@redhat.com>
 <CAHdzE-8V8o9sg9xmiJ9J0G3u=k6K-fHQssb5v09TPJvN2N=a1Q@mail.gmail.com>
Message-ID: <1466098998.17117.22.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-06-15 at 09:34 -0700, Venkatesh Srinivas wrote:
> Reviewed-by: Venkatesh Srinivas <venkateshs@google.com>
> 
> The same bit of code appears in fm10k and i40e/i40evf. ixgb appears
> to
> correctly return work_done.
> 
> ixgbe_poll also appears to return an?(minor) incorrect work_done in
> another case, BTW. It divides its
> budget between Rx rings associated with a vector. If any ring exceeds
> its share of the budget, ixgbe_poll
> claims to have consumed the full budget, even if a full budget of
> frames was not received in a single
> pass.
> 

So the correct return here would also be min between work_done and
budget, right? ie: we should still return the total work done instead
of the budget...?

Thanks,
Jake

> -- vs;
