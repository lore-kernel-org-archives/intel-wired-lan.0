From: David Rientjes <rientjes@google.com>
Date: Wed, 19 Aug 2015 17:18:15 -0700 (PDT)
Subject: [Intel-wired-lan] [Patch V3 5/9] i40e: Use numa_mem_id() to
 better	support memoryless node
In-Reply-To: <4197C471DCF8714FBA1FE32565271C148FFFF4D3@ORSMSX103.amr.corp.intel.com>
References: <1439781546-7217-1-git-send-email-jiang.liu@linux.intel.com>
 <1439781546-7217-6-git-send-email-jiang.liu@linux.intel.com>
 <4197C471DCF8714FBA1FE32565271C148FFFF4D3@ORSMSX103.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.10.1508191717450.30666@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 19 Aug 2015, Patil, Kiran wrote:

> Acked-by: Kiran Patil <kiran.patil@intel.com>

Where's the call to preempt_disable() to prevent kernels with preemption 
from making numa_node_id() invalid during this iteration?
