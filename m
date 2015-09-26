From: Singhai, Anjali <anjali.singhai@intel.com>
Date: Sat, 26 Sep 2015 00:00:24 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] i40e: Fix RS bit update in Tx
 path and disable force WB workaround
In-Reply-To: <1443223105.2987.48.camel@intel.com>
References: <1443207609-171288-1-git-send-email-anjali.singhai@intel.com>,
 <1443223105.2987.48.camel@intel.com>
Message-ID: <5611BDB7-8526-4213-82EB-0160494B8D2A@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jeff, I realized later that disable check for hang patch got squished to another pach from Catherine so you could drop that one. But since that one already got taken care off by Catherine,  just go ahead and apply this one.
Thanks
Anjali



Sent from my iPhone

> On Sep 25, 2015, at 4:18 PM, Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com> wrote:
> 
>> On Fri, 2015-09-25 at 12:00 -0700, Anjali Singhai Jain wrote:
>> This patch fixes the issue of forcing WB too often causing us to not
>> benefit from NAPI.
>> 
>> Without this patch we were forcing WB/arming interrupt too often
>> taking
>> away the benefits of NAPI and causing a performance impact.
>> 
>> With this patch we disable force WB in the clean routine for X710
>> and XL710 adapters. X722 adapters do not enable interrupt to force
>> a WB and benefit from WB_ON_ITR and hence force WB is left enabled
>> for those adapters.
>> For XL710 and X710 adapters if we have less than 4 packets pending
>> a software Interrupt triggered from service task will force a WB.
>> 
>> This patch also changes the conditions for setting RS bit as
>> described
>> in code comments. This optimizes when the HW does a tail bump amd
>> when
>> it does a WB. It also optimizes when we do a wmb.
>> 
>> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
>> ---
>> drivers/net/ethernet/intel/i40e/i40e_txrx.c | 126 ++++++++++++++++++
>> ----------
>> drivers/net/ethernet/intel/i40e/i40e_txrx.h |   2 +
>> 2 files changed, 86 insertions(+), 42 deletions(-)
> 
> This applied with a little massaging, but seeing that the second patch
> does not apply at all.  I am dropping this patch.
> 
> Please resend an updated patch against my next-queue tree, dev-queue
> branch.
