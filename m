From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 27 Oct 2021 12:46:07 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 0/4] ice: transmit
 improvement series
In-Reply-To: <7afd99cc66d66f81ce68e9bd9e9cc116cefab1eb.camel@intel.com>
References: <20211026000826.156803-1-jesse.brandeburg@intel.com>
 <7afd99cc66d66f81ce68e9bd9e9cc116cefab1eb.camel@intel.com>
Message-ID: <850d2742-2191-9cec-e585-dbbb1d796510@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/26/2021 9:21 AM, Nguyen, Anthony L wrote:

>> Jesse Brandeburg (4):
>>  ? ice: update to newer kernel API
>>  ? ice: use prefetch methods
>>  ? ice: tighter control over VSI_DOWN state
>>  ? ice: use modern kernel API for kick
> 
> It looks like patch 2 never made it to the list [1]. Seems like the
> email issues may be further reaching than kernel.org.
> 
> Thanks,
> Tony
> 
> [1] https://patchwork.ozlabs.org/project/intel-wired-
> lan/list/?series=268871

Thanks for letting me know!
The issue was root caused to a typo in the To:email address on my end, 
and I attempted to resend the patch with a correct reply-to, it seems to 
have failed to do what I wanted (but did show up on patchwork now) so 
please let me know if you want me to resend the whole series as a v2.

