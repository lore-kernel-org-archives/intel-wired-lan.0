From: Denys Vlasenko <dvlasenk@redhat.com>
Date: Thu, 21 Apr 2016 19:23:19 +0200
Subject: [Intel-wired-lan] [PATCH 3/3] e1000e:
 e1000e_cyclecounter_read(): do overflow check only if needed
In-Reply-To: <36CDDD56DDB4D44E911123902EFC26B05B47C768@HASMSX110.ger.corp.intel.com>
References: <1461167156-6737-1-git-send-email-dvlasenk@redhat.com>
 <1461167156-6737-3-git-send-email-dvlasenk@redhat.com>
 <36CDDD56DDB4D44E911123902EFC26B05B47C768@HASMSX110.ger.corp.intel.com>
Message-ID: <57190C87.7020103@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 04/21/2016 04:49 PM, Ruinskiy, Dima wrote:
> Not sure I follow (perhaps I am missing some background).
> Why do you assume there can be only 1 or 2 increments?

Different e1000e models have different timer cycle periods:

#define INCVALUE_96MHz          125
#define INCVALUE_SHIFT_96MHz    17
#define INCPERIOD_SHIFT_96MHz   2
#define INCPERIOD_96MHz         (12 >> INCPERIOD_SHIFT_96MHz)

#define INCVALUE_25MHz          40
#define INCVALUE_SHIFT_25MHz    18
#define INCPERIOD_25MHz         1

#define INCVALUE_24MHz          125
#define INCVALUE_SHIFT_24MHz    14
#define INCPERIOD_24MHz         3

The fastest is 96MHz, ~10ns, and we update the counter every 3 periods,
so two updates are 30ns apart.

That is.... fast. PCIe reads are in ~100ns territory.

So yes, you seem to be right. There can be more than two updates
between two PCIe reads.

