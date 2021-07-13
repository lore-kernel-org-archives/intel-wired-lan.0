From: Aaron Ma <aaron.ma@canonical.com>
Date: Tue, 13 Jul 2021 21:45:10 +0800
Subject: [Intel-wired-lan] [PATCH 2/2] igc: wait for the MAC copy when
 enabled MAC passthrough
In-Reply-To: <47117935-10d6-98e0-5894-ba104912ce25@intel.com>
References: <20210702045120.22855-1-aaron.ma@canonical.com>
 <20210702045120.22855-2-aaron.ma@canonical.com>
 <613e2106-940a-49ed-6621-0bb00bc7dca5@intel.com>
 <ad3d2d01-1d0a-8887-b057-e6a9531a05f4@canonical.com>
 <f9f9408e-9ba3-7ed9-acc2-1c71913b04f0@intel.com>
 <96106dfe-9844-1d9d-d865-619d78a0d150@canonical.com>
 <47117935-10d6-98e0-5894-ba104912ce25@intel.com>
Message-ID: <1a539d4d-10b4-5b9b-31e7-6aec57120356@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 7/8/21 12:24 PM, Neftin, Sasha wrote:
> I?would?to?like?suggest?checking?the?following?direction:
> 1. principal question: can we update the netdev device address after it is?already?set?during?probe??I?meant?perform?another:
> memcpy(netdev->dev_addr,?hw->mac.addr,?netdev->addr_len)?up?to?demand

Updating MAC addr may work.
Even at the end of probe, it still got the wrong MAC address, delay is still needed.

Aaron

> 2. We need to work with Intel's firmware engineer/group and define the message/event:?MAC?addressis?changed?and?should?be?updated.
> As I know MNG FW updates shadow registers. Since shadow registers are different from RAL/RAH registers - it could be a notification that the MAC?address?changed.?Let's?check?it.
