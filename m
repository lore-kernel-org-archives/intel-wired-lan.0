From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 18 Mar 2020 15:31:28 +0200
Subject: [Intel-wired-lan] [Regression] "e1000e: Add support for S0ix"
 breaks s2idle on Lenovo X1 Carbon 7th
In-Reply-To: <C9A08D85-D64B-44DD-8460-3405F2547D53@canonical.com>
References: <0A7D1E37-88A4-4E5A-8522-B80A8AE679EE@canonical.com>
 <8c0032bd-15be-734b-1b52-dedba72a8da3@intel.com>
 <897C8B9E-839A-4FC1-9411-B3CB141890BC@canonical.com>
 <540fd2d3-9187-1dba-185a-58d94c4c5b69@intel.com>
 <BA29B851-8765-4F47-AC98-E2D604595EA6@canonical.com>
 <38766b04-eec3-f4ce-5fe5-6352562b271c@intel.com>
 <FFE42849-4E95-4ADC-9B46-7A0F5B58508B@canonical.com>
 <6c1bcb34-a713-a6ea-7def-8a0e553ea0bb@intel.com>
 <C9A08D85-D64B-44DD-8460-3405F2547D53@canonical.com>
Message-ID: <c94e12da-efb2-5e7f-b6a7-726f0378268b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/18/2020 14:21, Kai-Heng Feng wrote:
> Hi Sasha,
> 
>> On Mar 18, 2020, at 16:50, Neftin, Sasha <sasha.neftin@intel.com> wrote:
> 
> [snipped]
> 
>> ok, let's understand where is PHY location.
> 
> Lenovo confirmed the PHY is inside the laptop.
> 
>> Since no docking connected why driver should run?
> 
> Because the SoC in the laptop has an I219 device?
> 
>> There is no RJ45 port on laptop.
> 
> The Lenovo ethernet dongle wires the RJ45 to the I219 device.
> 
>> S0ix flow same (I got confirmation from our architecture team) and should haven't impact on Sx.
>> if PHY located externally... during S0ix flow we try access to the PHY and it can be problem. Since laptop have no RJ45 connector driver not expected to run I though.
> 
> But the I219 device is always on the PCI bus so e1000e should bind to it?
> 
ok. Need to debug this system. We will escalate this problem to our PAE.
> Kai-Heng
> 

