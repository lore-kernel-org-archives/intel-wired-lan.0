From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 07 May 2015 10:49:07 -0700
Subject: [Intel-wired-lan] [PATCH v1 net-next 1/2] igb: add PHY support
 for Broadcom 5461S
In-Reply-To: <CAPg-hwmB-=fd_OjMbtL_Am5e9znX36KOnMnHNdwTMnCmQBeHPw@mail.gmail.com>
References: <1429302240-654-1-git-send-email-jtoppins@cumulusnetworks.com>
 <1430999388.32618.21.camel@jtkirshe-mobl>
 <CAPg-hwmB-=fd_OjMbtL_Am5e9znX36KOnMnHNdwTMnCmQBeHPw@mail.gmail.com>
Message-ID: <554BA593.6080703@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05/07/2015 06:41 AM, Andy Gospodarek wrote:
> On Thu, May 7, 2015 at 7:49 AM, Jeff Kirsher
> <jeffrey.t.kirsher@intel.com> wrote:
>> On Fri, 2015-04-17 at 13:23 -0700, Jonathan Toppins wrote:
>>> From: Alan Liebthal <alanl@cumulusnetworks.com>
>>>
>>> The Quanta LY8 Ethernet management port uses a Broadcom 5461S chip for
>>> the PHY layer. This adds support for this PHY to the Intel igb driver.
>>>
>>> Signed-off-by: Alan Liebthal <alanl@cumulusnetworks.com>
>>> Signed-off-by: Jonathan Toppins <jtoppins@cumulusnetworks.com>
>>> ---
>>>   drivers/net/ethernet/intel/igb/e1000_82575.c   |   20 +++++-
>>>   drivers/net/ethernet/intel/igb/e1000_defines.h |    1 +
>>>   drivers/net/ethernet/intel/igb/e1000_hw.h      |    1 +
>>>   drivers/net/ethernet/intel/igb/e1000_phy.c     |   79
>>> ++++++++++++++++++++++++
>>>   drivers/net/ethernet/intel/igb/e1000_phy.h     |    2 +
>>>   5 files changed, 102 insertions(+), 1 deletion(-)
>> After at lot of discussion on these changes, we would like to you to use
>> the PHYLib approach.  I know that means adding PHYLib support to our
>> drivers, which we currently do not have.
> Jeff,
>
> I think we would be willing to take on this task, but I would not like
> that to be a gating factor for upstream acceptance of the
> functionality added with this patch.  I see that Aaron has commented
> that no regressions were found with this patch, but based on current
> status in patchwork, it looks like Dave is waiting for something a bit
> more definitive before accepting it.  Can you ACK it first so we have
> support for this platform upstream and then we can go take a stab at
> phylib support for igb?
>
> Thanks,
>
> -andy

I agree with Jeff.  We already have the code from Tim Harvey which is 
adding PHYlib support for i210/i211, it shouldn't take much to extend 
the same kind of SGMII support for i350/i354.  Then with that you free 
yourself up to add whatever PHY you need in the future without having to 
get buy-off from Intel.  As is this patch set looks fishy to me since 
you are providing the

The fact is the merge window will still be open for a while since we are 
only at RC2.

- Alex
