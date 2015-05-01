From: Vick, Matthew <matthew.vick@intel.com>
Date: Fri, 1 May 2015 18:17:02 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: Update ITR scaling mechanism
 based on PCIe link speed
In-Reply-To: <1430427126.25212.6.camel@intel.com>
References: <1430352634-25084-1-git-send-email-jacob.e.keller@intel.com>
 <55419187.9040900@redhat.com> <1430427126.25212.6.camel@intel.com>
Message-ID: <D16910EA.761A6%matthew.vick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/30/15, 1:52 PM, "Keller, Jacob E" <jacob.e.keller@intel.com> wrote:

>On Wed, 2015-04-29 at 19:20 -0700, Alexander Duyck wrote:
>> 
>> Also I don't think I see any of the changes I suggested.  It seems like
>> this could still divide the interrupt throttle rate all the way down to
>>0.
>
>I'm going to defer this for a bit then, since it depends on other
>changes I wasn't aware of.. Matthew?
>
>Regards,
>Jake

Yes, we should definitely defer this for a bit.

Sorry Alex, bit of a misfire on this one. I still plan to incorporate the
changes you proposed.

Cheers,
Matthew

