From: Steffen Klassert <steffen.klassert@secunet.com>
Date: Thu, 19 Apr 2018 08:56:57 +0200
Subject: [Intel-wired-lan] [net] xfrm: allow to release xfrm_state with
 flush
In-Reply-To: <20180412190315.3102-2-jacek.kalwas@intel.com>
References: <20180412190315.3102-1-jacek.kalwas@intel.com>
 <20180412190315.3102-2-jacek.kalwas@intel.com>
Message-ID: <20180419065657.pltiiz3hfy2onuop@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Apr 12, 2018 at 12:03:14PM -0700, Jacek Kalwas wrote:
> Call to flush SAs doesn't release xfrm_state in case there was a
> traffic associated with that state and state was already deleted.
> 
> Given patch calls xfrm_policy_cache_flush despite of actual states
> deleted in xfrm_state_flush function.
> 
> Signed-off-by: Jacek Kalwas <jacek.kalwas@intel.com>

This is a fix that needs to be backported to -stable,
so please add a proper 'Fixes:' tag and resend based on
the ipsec tree.

Thanks!
