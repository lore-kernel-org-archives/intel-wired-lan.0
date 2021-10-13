From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 13 Oct 2021 16:15:20 -0700
Subject: [Intel-wired-lan] [PATCH v2 net] ice: Avoid crash from
 unnecessary IDA free
In-Reply-To: <20211004121525.6384-1-david.m.ertman@intel.com>
References: <20211004121525.6384-1-david.m.ertman@intel.com>
Message-ID: <0215a7cc-0a9e-874d-0962-638b5b2a3489@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/4/2021 5:15 AM, Dave Ertman wrote:
> In the remove path, there is an attempt to free the aux_idx IDA whether
> it was allocated or not.  This can potentially cause a crash when
> unloading the driver on systems that do not initialize support for RDMA.
> But, this free cannot be gated by the status bit for RDMA, since it is
> allocated if the driver detects support for RDMA at probe time, but the
> driver can enter into a state where RDMA is not supported after the IDA
> has been allocated at probe time and this would lead to a memory leak.
> 
> Initialize aux_idx to an invalid value and check for a valid value when
> unloading to determine if an IDA free is necessary.
> 
> Fixes: d25a0fc41c1f9 ("ice: Initialize RDMA support")
> Reported-by: Jun Miao <jun.miao@windriver.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>

Please send upstream!
With this patch applied I can now rmmod my ice driver without a panic!

Tested-by: Jesse Brandeburg <jesse.brandeburg@intel.com>


