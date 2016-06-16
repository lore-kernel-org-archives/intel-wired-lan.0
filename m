From: Patil, Kiran <kiran.patil@intel.com>
Date: Thu, 16 Jun 2016 04:15:57 +0000
Subject: [Intel-wired-lan] [next PATCH S38 2/7] i40e: enable VSI
 broadcast promiscuous mode instead of adding broadcast filter
In-Reply-To: <576209FC.5000709@onemain.com>
References: <1466034139-11828-1-git-send-email-bimmy.pujari@intel.com>
 <1466034139-11828-3-git-send-email-bimmy.pujari@intel.com>
 <576209FC.5000709@onemain.com>
Message-ID: <4197C471DCF8714FBA1FE32565271C149019FC55@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks Shannon.

We shall take care of it.

-- Kiran P.

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Shannon Nelson
Sent: Wednesday, June 15, 2016 7:08 PM
To: Pujari, Bimmy <bimmy.pujari@intel.com>; intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] [next PATCH S38 2/7] i40e: enable VSI broadcast promiscuous mode instead of adding broadcast filter



On 06/15/2016 04:42 PM, Bimmy Pujari wrote:
> From: Kiran Patil <kiran.patil@intel.com>
>
> This patch sets VSI brodcast promiscuous mode during VSI add sequence 
> and prevents adding MAC filter if specified MAC address is broadcast.
[ ... ]
> Likewise tried the test case mentioned in HSD where source MAC is 
> broadcast and those packets are getting forwarded to one of the 
> rx-queue.
> HSD-number: 7661069
> HSD-database: LADSW
We shouldn't be seeing the internal bug tracking information.  If there's another useful test case it should be detailed here.

sln

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
