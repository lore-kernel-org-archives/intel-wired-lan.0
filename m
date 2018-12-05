From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Wed, 5 Dec 2018 16:50:57 +0530
Subject: [Intel-wired-lan] [LKP] [mm] 19717e78a0:
 stderr.if(target_node==NUMA_NO_NODE){
In-Reply-To: <20181205050057.GB23332@shao2-debian>
References: <20181205050057.GB23332@shao2-debian>
Message-ID: <d75d097f-78a5-865e-a80a-b1e6faeff337@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/05/2018 10:30 AM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 19717e78a04d51512cf0e7b9b09c61f06b2af071 ("[PATCH V2] mm: Replace all open encodings for NUMA_NO_NODE")
> url: https://github.com/0day-ci/linux/commits/Anshuman-Khandual/mm-Replace-all-open-encodings-for-NUMA_NO_NODE/20181126-203831
> 
> 
> in testcase: perf-sanity-tests
> with following parameters:
> 
> 	perf_compiler: gcc
> 	ucode: 0x7000013
> 
> 
> 
> on test machine: 16 threads Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz with 8G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):

The fix (in Andrew's staging tree) from Stephen Rothwell which adds <linux/numa.h>
definitions to <tools/include/linux/numa.h> should fix this.
