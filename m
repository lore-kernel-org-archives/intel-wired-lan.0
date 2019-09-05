From: Gavin Lambert <intel@mirality.co.nz>
Date: Thu, 05 Sep 2019 15:59:57 +1200
Subject: [Intel-wired-lan] [e1000e] Linux 4.9: unable to send packets
 after link recovery with patched driver
In-Reply-To: <53d81b8c69ddeba6f76128f308ff5275@mirality.co.nz>
References: <3acf459ddbbd30687cda0a79523afe04@mirality.co.nz>
 <bec9f546d5a5a46586af0ac93d36f84f@mirality.co.nz>
 <000661bda5687541e895a949c76712fb@mirality.co.nz>
 <d3118220-e599-44cd-5ed6-43259c5fc2c2@intel.com>
 <3a63201c552a9cb6a9737fec92bc1264@mirality.co.nz>
 <f4a18bf808e6f30e9691e127722f851b@mirality.co.nz>
 <f6b7b539ece1ba352c60c6dc976a3ce2@mirality.co.nz>
 <0300439f389950a9f9baaaaf5e3ea697@mirality.co.nz>
 <aafb4ac9-6825-300c-6dee-1b603c09e373@molgen.mpg.de>
 <20190903092046.GB12325@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DCAC1FF@hasmsx108.ger.corp.intel.com>
 <f5b988f9-25cf-db4a-53f5-9bb7edc8fb51@molgen.mpg.de>
 <0159f1cd031ce326447621f1a22f60fc@mirality.co.nz>
 <5B8DA87D05A7694D9FA63FD143655C1B9DCAF25E@hasmsx108.ger.corp.intel.com>
 <53d81b8c69ddeba6f76128f308ff5275@mirality.co.nz>
Message-ID: <77e8ef04e6d1318341e331abee4ce5f6@mirality.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-09-04 23:08, I wrote:
> On 2019-09-04 22:06, Winkler, Tomas wrote:
>> You can still disable runtime power management via sysfs and
>> permanently using udev rule on your particular system.
>> e.g. ATTR{../../power/control}="on"
> 
> I'll do some more testing on this tomorrow, but I do recall trying
> setting power/control to "on" (via sysfs) for the device:
> 
>   00:16.0 Communication controller: Intel Corporation Sunrise Point-H
> CSME HECI #1 (rev 31)
> 
> which was the one that I noticed was suspended.  Is this the mei 
> device?
> 
> In any case when I tried it before it didn't seem to help, but I think
> this was after link-down and things had already failed.  I'll try
> testing a few more cases, including doing it pre-emptively.

Good news: while forcing the mei_me device to "on" does not recover from 
the problem once it has happened, it does appear to prevent the problem 
from happening.  (I assume this is because it effectively reverts the 
problem commit without any actual code changes.)

I was able to get this to happen on boot by setting 
/etc/udev/rules.d/20-mei.rules:

     ACTION=="add",KERNEL=="mei0",ATTR{../../power/control}="on"

(Initially I tried to match on DRIVER=="mei_me" to avoid the parent 
attribute reference, but this didn't trigger on boot.  The above seems 
to work though.)

This is probably a sufficient workaround for now to keep me happy.  Is 
there anything else you wanted me to test while I have the system handy?

(FWIW, I did previously verify that the original problem also occurs in 
Linux 4.19, though I don't recall the precise version at the moment.)
