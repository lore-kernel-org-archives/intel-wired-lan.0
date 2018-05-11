From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Fri, 11 May 2018 13:26:04 +0200
Subject: [Intel-wired-lan] [PATCH] Documentation: e100: Update the Intel
 10/100 driver doc
In-Reply-To: <184eb69708b57be21bf2294d62de12d3b6e7ff7e.camel@intel.com>
References: <20180510192013.15363-1-jeffrey.t.kirsher@intel.com>
 <37d8dc04-a0d4-7e0c-bb46-03fc8c0d02ff@molgen.mpg.de>
 <184eb69708b57be21bf2294d62de12d3b6e7ff7e.camel@intel.com>
Message-ID: <a50758b3-1365-f6c7-3ec0-e02307531445@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jeff,


On 05/10/18 22:44, Jeff Kirsher wrote:
> On Thu, 2018-05-10 at 21:52 +0200, Paul Menzel wrote:

>> Am 10.05.2018 um 21:20 schrieb Jeff Kirsher:
>>> Over the years, several of the links have changed or are no longer
>>> valid
>>> so update them.  In addition, the default values were incorrect for
>>> a
>>> couple of parameters.
>>>
>>> Converted the text file to the reStructuredText (RST) format, since
>>> the
>>> Linux kernel documentation now uses this format for documentation.
>>
>> Thank you for updating the documentation.

[?]

>>> -March 15, 2011
>>> +March 15, 2013
>>
>> Why not use the current date?
> 
> I debated using the latest date, but since these documentational fixes
> were actually done back on March 15, 2013 internally and I am just now
> getting around to pushing these changes upstream, I thought it best to
> keep the date that these changes were actually made internally.

Understood. Please just mention that in the commit message.

>>>    Contents
>>>    ========
>>> @@ -36,16 +36,9 @@ Channel Bonding documentation can be found in
>>> the Linux kernel source:
>>>    Identifying Your Adapter
>>>    ========================
>>>    
>>> -For more information on how to identify your adapter, go to the
>>> Adapter &
>>> -Driver ID Guide at:
>>> -
>>> -  http://support.intel.com/support/network/adapter/pro100/21397.htm
>>> -
>>> -For the latest Intel network drivers for Linux, refer to the
>>> following
>>> -website. In the search field, enter your adapter name or type, or
>>> use the
>>> -networking link on the left to search for your adapter:
>>> -
>>> -  http://downloadfinder.intel.com/scripts-df/support_intel.asp
>>> +For information on how to identify your adapter, and for the
>>> latest Intel
>>> +network drivers, refer to the Intel Support website:
>>> +http://www.intel.com/support
>>
>> Please use HTTPS.
> 
> Using https:// for the above URL returns the incorrect URL desired.

Both HTTP and HTTPS redirect to 
<https://www.intel.com/content/www/us/en/support.html> on my system.

> You noted below that because it is at the start of the line, I should
> use HTTPS.  I am not following the reason why, does that mean if I
> indent it, I can keep the http://?

That must be a misunderstanding, and I do not see, where I wrote that. 
Sorry, if my English was incorrect. So, no, it has nothing to do with 
indentation only that the line was touched.

>>>    
>>>    Driver Configuration Parameters
>>>    ===============================
>>> @@ -57,22 +50,26 @@ Rx Descriptors: Number of receive descriptors.
>>> A receive descriptor is a data
>>>       structure that describes a receive buffer and its attributes
>>> to the network
>>>       controller. The data in the descriptor is used by the
>>> controller to write
>>>       data from the controller to host memory. In the 3.x.x driver
>>> the valid range
>>> -   for this parameter is 64-256. The default value is 64. This
>>> parameter can be
>>> -   changed using the command:
>>> +   for this parameter is 64-256. The default value is 256. This
>>> parameter can be
>>> +   changed using the command::
>>>    
>>> -   ethtool -G eth? rx n, where n is the number of desired rx
>>> descriptors.
>>> +   ethtool -G eth? rx n
>>> +
>>> +   Where n is the number of desired Rx descriptors.
>>>    
>>>    Tx Descriptors: Number of transmit descriptors. A transmit
>>> descriptor is a data
>>>       structure that describes a transmit buffer and its attributes
>>> to the network
>>>       controller. The data in the descriptor is used by the
>>> controller to read
>>>       data from the host memory to the controller. In the 3.x.x
>>> driver the valid
>>> -   range for this parameter is 64-256. The default value is 64.
>>> This parameter
>>> -   can be changed using the command:
>>> +   range for this parameter is 64-256. The default value is 128.
>>> This parameter
>>> +   can be changed using the command::
>>> +
>>> +   ethtool -G eth? tx n
>>>    
>>> -   ethtool -G eth? tx n, where n is the number of desired tx
>>> descriptors.
>>> +   Where n is the number of desired Tx descriptors.
>>>    
>>>    Speed/Duplex: The driver auto-negotiates the link speed and
>>> duplex settings by
>>> -   default. The ethtool utility can be used as follows to force
>>> speed/duplex.
>>> +   default. The ethtool utility can be used as follows to force
>>> speed/duplex.::
>>>    
>>>       ethtool -s eth?  autoneg off speed {10|100} duplex {full|half}
>>>    
>>> @@ -81,7 +78,7 @@ Speed/Duplex: The driver auto-negotiates the link
>>> speed and duplex settings by
>>>    
>>>    Event Log Message Level:  The driver uses the message level flag
>>> to log events
>>>       to syslog. The message level can be set at driver load time.
>>> It can also be
>>> -   set using the command:
>>> +   set using the command::
>>>    
>>>       ethtool -s eth? msglvl n
>>>    
>>> @@ -112,9 +109,9 @@ Additional Configurations
>>>      ---------------------
>>>      In order to see link messages and other Intel driver
>>> information on your
>>>      console, you must set the dmesg level up to six. This can be
>>> done by
>>> -  entering the following on the command line before loading the
>>> e100 driver:
>>> +  entering the following on the command line before loading the
>>> e100 driver::
>>>    
>>> -       dmesg -n 8
>>> +       dmesg -n 6
>>>    
>>>      If you wish to see all messages issued by the driver, including
>>> debug
>>>      messages, set the dmesg level to eight.
>>> @@ -146,7 +143,8 @@ Additional Configurations
>>>    
>>>      NAPI (Rx polling mode) is supported in the e100 driver.
>>>    
>>> -  See www.cyberus.ca/~hadi/usenix-paper.tgz for more information
>>> on NAPI.
>>> +  See https://wiki.linuxfoundation.org/networking/napi for more
>>> information
>>> +  on NAPI.
>>>    
>>>      Multiple Interfaces on Same Ethernet Broadcast Network
>>>      ------------------------------------------------------
>>> @@ -160,7 +158,7 @@ Additional Configurations
>>>      If you have multiple interfaces in a server, either turn on ARP
>>>      filtering by
>>>    
>>> -  (1) entering: echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter
>>> +  (1) entering:: echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter
>>>          (this only works if your kernel's version is higher than
>>> 2.4.5), or
>>>    
>>>      (2) installing the interfaces in separate broadcast domains
>>> (either
>>> @@ -169,15 +167,11 @@ Additional Configurations
>>>    
>>>    Support
>>>    =======
>>> -
>>>    For general information, go to the Intel support website at:
>>> +http://www.intel.com/support/
>>
>> As you touch the line, please use HTTPS.
> 
> Same for this URL as well.
> 
>>>    
>>> -    http://support.intel.com
>>> -
>>> -    or the Intel Wired Networking project hosted by Sourceforge
>>> at:
>>> -
>>> -    http://sourceforge.net/projects/e1000
>>> -
>>> -If an issue is identified with the released source code on the
>>> supported
>>> -kernel with a supported adapter, email the specific information
>>> related to the
>>> -issue to e1000-devel at lists.sourceforge.net.
>>> +or the Intel Wired Networking project hosted by Sourceforge at:
>>> +http://sourceforge.net/projects/e1000
>>
>> Please use HTTPS.
> 
> I can make this change.
> 
>>
>>> +If an issue is identified with the released source code on a
>>> supported kernel
>>> +with a supported adapter, email the specific information related
>>> to the issue
>>> +to e1000-devel at lists.sf.net.
>>> diff --git a/Documentation/networking/index.rst
>>> b/Documentation/networking/index.rst
>>> index cbd9bdd4a79e..d11a62977edd 100644
>>> --- a/Documentation/networking/index.rst
>>> +++ b/Documentation/networking/index.rst
>>> @@ -10,6 +10,7 @@ Contents:
>>>       batman-adv
>>>       can
>>>       dpaa2/index
>>> +   e100
>>>       kapi
>>>       z8530book
>>>       msg_zerocopy
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index b22be10d5916..0a5e36927540 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -7080,7 +7080,7 @@ Q:	http://patchwork.ozlabs.org/project
>>> /intel-wired-lan/list/
>>>    T:	git
>>> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-
>>> queue.git
>>>    T:	git
>>> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-
>>> queue.git
>>>    S:	Supported
>>> -F:	Documentation/networking/e100.txt
>>> +F:	Documentation/networking/e100.rst
>>>    F:	Documentation/networking/e1000.txt
>>>    F:	Documentation/networking/e1000e.txt
>>>    F:	Documentation/networking/igb.txt
>>>
>>
>> Maybe the URL changes to HTTPS should be done in a follow-up commit.


Kind regards,

Paul

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180511/e23e0ca1/attachment-0001.p7s>
