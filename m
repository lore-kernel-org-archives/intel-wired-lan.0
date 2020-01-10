From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 9 Jan 2020 22:47:23 -0800
Subject: [Intel-wired-lan] [PATCH net v2] i40e/iavf: use better trace
 path
In-Reply-To: <9400163aa83bbd414e43e2aebd5d9e1e23e394b5.camel@intel.com>
References: <20200103022342.820175-1-jesse.brandeburg@intel.com>
 <4185adba-3420-32ad-014d-64eee768d183@intel.com>
 <07213c35-b4fb-e230-75a2-1d11d51815c9@intel.com>
 <9400163aa83bbd414e43e2aebd5d9e1e23e394b5.camel@intel.com>
Message-ID: <20200109224723.00003603@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 9 Jan 2020 09:43:52 -0800 Jeff wrote:
> On Wed, 2020-01-08 at 14:55 -0800, Jacob Keller wrote:
> > On 1/8/2020 2:49 PM, Jacob Keller wrote:  
>  [...]  
>  [...]  
>  [...]  
>  [...]  
>  [...]  
> > 
> > It looks like this is handled in driver's Makefile via:
> > 
> > ccflags-y += -I$(src)>-->------->-------# needed for trace events
> > 
> > or the following:
> > 
> > CFLAGS_trace.o := -I$(src)  
> 
> I like the above solution, as it is much cleaner and less prone for
> future errors, if the directory patch would change for whatever reason.

Hi Jeff, please drop this patch, I found after bisecting and finding a
commit in January of 2019 that causes my issue, that if I just change
the command sequence I do, everything works fine.

FAIL: make O=../foo.obj M=drivers/net/ethernet/intel/i40e

PASS: make O=../foo.obj M=`pwd`/drivers/net/ethernet/intel/i40e

So the change in behavior is somewhat introduced recently (a year ago)
but me just having to learn a new trick is better than trying to fix
this in the kernel.

Jesse
