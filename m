From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 19 Oct 2021 20:49:21 +0200
Subject: [Intel-wired-lan] [PATCH net] ice: Add missing device ids
In-Reply-To: <1494d7bcbed00caff6f6391512dd8db5256d3770.camel@intel.com>
References: <20211019152758.58277-1-anthony.l.nguyen@intel.com>
 <c2e59ebe-4a7b-b2d7-f15d-759ad26c006b@molgen.mpg.de>
 <1494d7bcbed00caff6f6391512dd8db5256d3770.camel@intel.com>
Message-ID: <bb9307c2-58d4-362e-dafb-a6d3c1afd587@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Tony,


Am 19.10.21 um 19:53 schrieb Nguyen, Anthony L:
> On Tue, 2021-10-19 at 18:24 +0200, Paul Menzel wrote:

>> Am 19.10.21 um 17:27 schrieb Tony Nguyen:

[?]

>>> As part of support for E810 XXV devices, some device ids were >
>>> inadvertently left out. Add those missing ids.
>> Please mention the source of these IDs.
> 
> I'm not sure I get this comment. These are the IDs for the NIC itself.

Sorry, for being unclear. I meant, you probably didn?t get the hardware 
and read out the IDs using `lspci` or so, but looked in some 
specification, what IDs are used for the hardware?


Kind regards,

Paul
