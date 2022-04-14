From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 14 Apr 2022 10:07:18 +0300
Subject: [Intel-wired-lan] I218-LM uses > 1 W with low traffic
In-Reply-To: <20e6d930-c50f-45b7-f98e-3d11c35a09d1@molgen.mpg.de>
References: <bff5f4d7-bb85-e3fa-b8b1-76d1b8e0133a@molgen.mpg.de>
 <9505bc04-edbd-ab64-bc95-a06150bbba38@intel.com>
 <20e6d930-c50f-45b7-f98e-3d11c35a09d1@molgen.mpg.de>
Message-ID: <9a5af9c0-e58a-250c-b030-05e3b73035b9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/7/2022 18:58, Paul Menzel wrote:
> Dear Sasha,
> 
> 
> Am 07.04.22 um 13:03 schrieb Neftin, Sasha:
>> On 4/6/2022 13:09, Paul Menzel wrote:
> 
>>> On a Dell Latitude E7250 with Debian sid/unstable, PowerTOP 2.14 
>>> reports the network device uses over 1.5 Watt, which is almost ten 
>>> percent of the whole system.
>>>
>>> ?????? 1.62 W??? 435,9 pkts/s??????????????? Device 
>>> Netzwerkschnittstelle: eno1 (e1000e)
>>>
>>> ???? $ lspci -nn | grep Ether
>>> ???? 00:19.0 Ethernet controller [0200]: Intel Corporation Ethernet 
>>> Connection (3) I218-LM [8086:15a2] (rev 03)
>>> ???? $ uname -a
>>> ???? Linux ersatz 5.17.0-trunk-amd64 #1 SMP PREEMPT Debian 
>>> 5.17.1-1~exp1 (2022-03-29) x86_64 GNU/Linux
>>>
>>> ?From atop:
>>>
>>> ???? NET |? eno1????? 0% |? pcki??? 2421 |? pcko??? 2194 |? sp 1000 
>>> Mbps |? si 1501 Kbps? | so? 140 Kbps? | erri?????? 0? | erro?????? 0  
>>> | drpo ????? 0? |
>>>
>>> So I receive 1.5 Mbps, and send 0.14 Mbps.
>>>
>>> Is such high energy usage expected of the network hardware?
> 
>> It is not the power consumption we expected.How do you measure it? (as 
>> I know powertop does not show it)
> 
> On my system, PowerTOP shows it. Though maybe it?s a bug in PowerTOP?s 
> power usage estimation algorithm. No idea. At least with no network 
> cable connected, it shows zero Watts being used.
> 
>  ??????? 0 mW????? 0,0 pkts/s? Netzwerkschnittstelle: eno1 (e1000e)
> 
> 
>> We will try to find out about power consumption.
> 
> Thank you very much.The power consumption during normal operation mode expected to be ~600mW.
> 
> 
> Kind regards,
> 
> Paull

