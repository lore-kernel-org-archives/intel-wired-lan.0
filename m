From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 16 Apr 2020 21:04:41 +0300
Subject: [Intel-wired-lan] Pls provide some advice - e1000e Linux link
 down
In-Reply-To: <61CC2BC414934749BD9F5BF3D5D940449863D544@ORSMSX112.amr.corp.intel.com>
References: <CABcq3pESeM2aF=HP-j4-iu2fwaxF7+mr65zTgFaBK8prmu+srw@mail.gmail.com>
 <61CC2BC414934749BD9F5BF3D5D940449863D544@ORSMSX112.amr.corp.intel.com>
Message-ID: <1d6ca38c-13f8-9478-b746-0bf3dff08be6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/16/2020 19:16, Kirsher, Jeffrey T wrote:
>> From: Andrew Melnichenko <andrew@daynix.com>
>> Sent: Saturday, April 11, 2020 12:56
>> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
>> Subject: Pls provide some advice - e1000e Linux link down
>>
>> Yo,
>> I'm a humble linux developer, currently I'm researching the issue with e1000e driver that can't handle "link down" on Linux guest(https://bugzilla.redhat.com/show_bug.cgi?id=1707441).
>> For now I've found that qemu can't raise LSC interrupts. But, on Windows guests the issue doesn't reproduce.
>> I've researched spec and the driver and for now, my main suspicion is still the issue in qemu and I have few hacks for "fixing".
>> But because on Windows guests that issue wasn't reproduced and I don't have a "real" device - I have a question:
>> Does "real" e1000e with Linux driver detect cable removing?
Definitely - LSC detected by watchdog.Should I look more the driver?
Please, try work with latest stable version from kernel.org. (any 
restrictions?)
>> Currently I have one hack for the driver that would "fix" the issue(small differences in interrupt clearing).
> 
> Adding the e1000e developers and the Intel Wired LAN mailing list...
> 
Hello Andrew,
Did you reproduced this problem on the latest stable version from 
kernel.org? I wonder if it only "qemu" problem. Looks as wrong 
representation in /sys/class/net/$nic/operstate

