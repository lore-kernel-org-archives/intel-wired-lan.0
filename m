From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 22 Aug 2018 09:47:35 -0700
Subject: [Intel-wired-lan] [PATCH v3] Documentation: e1000e: Update
 kernel documentation
In-Reply-To: <a7f5325365d3941a31b44e5b8f75ba1b65238775.camel@intel.com>
References: <20180821213913.32528-1-jeffrey.t.kirsher@intel.com>
 <8a8e1873-fd5c-07d0-0081-8023fa432709@oracle.com>
 <a7f5325365d3941a31b44e5b8f75ba1b65238775.camel@intel.com>
Message-ID: <3d4e95c2-8afe-bfc9-2473-1b8caa9594b6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/22/2018 9:28 AM, Jeff Kirsher wrote:
> On Wed, 2018-08-22 at 09:04 -0700, Shannon Nelson wrote:
>> On 8/21/2018 2:39 PM, Jeff Kirsher wrote:
>>> Updated the e1000e kernel documentation with the latest
>>> information.
>>> Also remove the command line parameters, which do not exist with
>>> the
>>> in-kernel driver.  Converted the documentation to the RST format.
>>>
>>> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>>> ---
>>> v1/v2: initial documentation update
>>>
>>> v3: convert to RST format, remove module parameters that do not
>>> exist
>>>        and add SPDX header
>>
>> It looks like you removed *all* the module parameters - did you
>> really
>> want to do that?
> 
> Yes, after reviewing the in-kernel driver, the only module parameter is
> "debug".  I know our current and past documentation does not show
> "debug" as a module parameter, so I working with our documentation team
> to come up with useful text/documentation for the debug module
> parameter for this document and all our other driver documentation.
> 

Huh... the code I see in my recent copy of net-next has the file
    drivers/net/ethernet/intel/e1000e/param.c
with several parameters in it, and using modinfo shows several parm entries:

# modinfo e1000e
filename: 
/lib/modules/4.18.0-rc8-ipsec-vlan+/kernel/drivers/net/ethernet/intel/e1000e/e1000e.ko
version:        3.2.6-k
license:        GPL
description:    Intel(R) PRO/1000 Network Driver
author:         Intel Corporation, <linux.nics@intel.com>
srcversion:     E5F1BBB6319ACF9CF582C86
alias:          pci:v00008086d000015E2sv*sd*bc*sc*i*
   [...]
intree:         Y
name:           e1000e
vermagic:       4.18.0-rc8-ipsec-vlan+ SMP mod_unload modversions
parm:           debug:Debug level (0=none,...,16=all) (int)
parm:           copybreak:Maximum size of packet that is copied to a new 
buffer on receive (uint)
parm:           TxIntDelay:Transmit Interrupt Delay (array of int)
parm:           TxAbsIntDelay:Transmit Absolute Interrupt Delay (array 
of int)
parm:           RxIntDelay:Receive Interrupt Delay (array of int)
parm:           RxAbsIntDelay:Receive Absolute Interrupt Delay (array of 
int)
parm:           InterruptThrottleRate:Interrupt Throttling Rate (array 
of int)
parm:           IntMode:Interrupt Mode (array of int)
parm:           SmartPowerDownEnable:Enable PHY smart power down (array 
of int)
parm:           KumeranLockLoss:Enable Kumeran lock loss workaround 
(array of int)
parm:           WriteProtectNVM:Write-protect NVM [WARNING: disabling 
this can lead to corrupted NVM] (array of int)
parm:           CrcStripping:Enable CRC Stripping, disable if your BMC 
needs the CRC (array of int)

sln
