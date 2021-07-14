From: Ruinskiy, Dima <dima.ruinskiy@intel.com>
Date: Wed, 14 Jul 2021 12:13:25 +0300
Subject: [Intel-wired-lan] [PATCH 2/2] igc: wait for the MAC copy when
 enabled MAC passthrough
In-Reply-To: <1a539d4d-10b4-5b9b-31e7-6aec57120356@canonical.com>
References: <20210702045120.22855-1-aaron.ma@canonical.com>
 <20210702045120.22855-2-aaron.ma@canonical.com>
 <613e2106-940a-49ed-6621-0bb00bc7dca5@intel.com>
 <ad3d2d01-1d0a-8887-b057-e6a9531a05f4@canonical.com>
 <f9f9408e-9ba3-7ed9-acc2-1c71913b04f0@intel.com>
 <96106dfe-9844-1d9d-d865-619d78a0d150@canonical.com>
 <47117935-10d6-98e0-5894-ba104912ce25@intel.com>
 <1a539d4d-10b4-5b9b-31e7-6aec57120356@canonical.com>
Message-ID: <20daa122-aaec-0c6b-23f5-d2be2fcab1e9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello, Aaron, Sasha,

On 13/07/2021 16:45, Aaron Ma wrote:
> 
> On 7/8/21 12:24 PM, Neftin, Sasha wrote:
>> I?would?to?like?suggest?checking?the?following?direction:
>> 1. principal question: can we update the netdev device address after 
>> it is?already?set?during?probe??I?meant?perform?another:
>> memcpy(netdev->dev_addr,?hw->mac.addr,?netdev->addr_len)?up?to?demand
> 
> Updating MAC addr may work.
> Even at the end of probe, it still got the wrong MAC address, delay is 
> still needed.
> 
> Aaron
> 
>> 2. We need to work with Intel's firmware engineer/group and define the 
>> message/event:?MAC?addressis?changed?and?should?be?updated.
>> As I know MNG FW updates shadow registers. Since shadow registers are 
>> different from RAL/RAH registers - it could be a notification that the 
>> MAC?address?changed.?Let's?check?it.

There is an interrupt which the FW can issue to the driver to indicate 
that MAC address has been changed. At that point the driver can update 
the MAC in its internal structures.

The important question is - is there away to update the OS structures at 
that point so that the MAC address change propagates through all the 
network stack. Some network stacks do not support such an update, except 
during device initialization (probe), so in such environments a delay is 
the only workaround, and it is a problematic one as we know.

If we find a mechanism by which the device driver can tell the Linux 
network stack - "My MAC address has changed; please update it", we can 
implement it differently, and not need this delay. Who can help us with 
this inquiry?

Thanks,
--Dima
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
