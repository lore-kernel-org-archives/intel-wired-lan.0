From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 4 Jan 2018 09:33:13 -0800
Subject: [Intel-wired-lan] Anybody knows what
 "i40e_dev_interrupt_handler(): ICR0: malicious programming detected" means?
In-Reply-To: <79BBBFE6CB6C9B488C1A45ACD284F51961D8D9C3@SHSMSX103.ccr.corp.intel.com>
References: <79BBBFE6CB6C9B488C1A45ACD284F51961D8D9C3@SHSMSX103.ccr.corp.intel.com>
Message-ID: <20180104093313.000035f3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 4 Jan 2018 13:03:03 +0000
"Yang, Yi Y" <yi.y.yang@intel.com> wrote:

> Hi, all
> 
> I found DPDK 17.11 has the below error information when I run OpenContrail which uses KNI and 25G NIC by DPDK.
> 
> 2018-01-03 22:47:09,278 i40e_dev_interrupt_handler(): ICR0: malicious programming detected
> 
> Anybody knows what happened? How can I work around this issue?

I think you've got the wrong list, you should probably try working this
through the DPDK support lists.  This list is for kernel i40e driver
issues.
