From: Shannon Nelson <sln@onemain.com>
Date: Wed, 15 Jun 2016 19:07:56 -0700
Subject: [Intel-wired-lan] [next PATCH S38 2/7] i40e: enable VSI
 broadcast promiscuous mode instead of adding broadcast filter
In-Reply-To: <1466034139-11828-3-git-send-email-bimmy.pujari@intel.com>
References: <1466034139-11828-1-git-send-email-bimmy.pujari@intel.com>
 <1466034139-11828-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <576209FC.5000709@onemain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



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
We shouldn't be seeing the internal bug tracking information.  If 
there's another useful test case it should be detailed here.

sln

