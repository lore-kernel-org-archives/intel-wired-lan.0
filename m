From: John Fastabend <john.r.fastabend@intel.com>
Date: Mon, 18 May 2015 15:47:34 -0700
Subject: [Intel-wired-lan] [net-next PATCH 1/8] flow: create nl
 interface to wrap low level flow msg details
In-Reply-To: <1431989159.2558.14.camel@jtkirshe-mobl>
References: <20150518220327.14831.64876.stgit@azvasil-mobl1.amr.corp.intel.com>
 <1431989159.2558.14.camel@jtkirshe-mobl>
Message-ID: <555A6C06.6070205@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05/18/2015 03:45 PM, Jeff Kirsher wrote:
> On Mon, 2015-05-18 at 15:03 -0700, John Fastabend wrote:
>> From: John Fastabend <john.r.fastabend@intel.com>
>>
>> Some low-level functions that can be used to interface with
>> API from other programs without having to invoke NETLINK
>> primitives.
>>
>> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
>> ---
>>  include/flowlib_nl.h |   75 ++++++
>>  lib/Makefile.am      |    2 
>>  lib/flowlib_nl.c     |  657
>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  src/flow.c           |  266 +++-----------------
>>  4 files changed, 773 insertions(+), 227 deletions(-)
>>  create mode 100644 include/flowlib_nl.h
>>  create mode 100644 lib/flowlib_nl.c
> 
> Will the other 7 patches be posted as well? :-)
> 

Ah dang failed to hit Ctl-C quickly enough... Sorry this is against
a different repository. The danger of having multiple terminals open
and using Ctl-r for shortcuts.

So just drop it. :)

Thanks and sorry for the noise.
