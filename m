From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 17 Nov 2021 23:51:30 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: Removed unused
 ICE_FLOW_SEG_HDRS_L2_MASK
In-Reply-To: <b06891ed-4e46-d37f-70a3-391026ed7a4d@molgen.mpg.de>
References: <20211117221038.70579-1-anthony.l.nguyen@intel.com>
 <b06891ed-4e46-d37f-70a3-391026ed7a4d@molgen.mpg.de>
Message-ID: <c4abc512a80261c88b989e48687d6831f658428e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-11-17 at 23:17 +0100, Paul Menzel wrote:
> Dear Tony,
> 
> 
> Am 17.11.21 um 23:10 schrieb Tony Nguyen:
> > ICE_FLOW_SEG_HDRS_L2_MASK is not being used; remove the define.
> 
> Nit: It?d be great if you used imperative mood (present tense) in the
> summary: Remove unused ?.
> 

I can do that. I'll send a v2 shortly.

Thanks,
Tony

> > Reported-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
