From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 19 Oct 2017 11:34:24 +0300
Subject: [Intel-wired-lan] Packet loss on 82571EB with kernel 4.9
In-Reply-To: <SG2PR03MB187249CC7E902081B5863FC984420@SG2PR03MB1872.apcprd03.prod.outlook.com>
References: <SG2PR03MB187291B811B5438AEADC53AE844C0@SG2PR03MB1872.apcprd03.prod.outlook.com>
 <1508345023.13406.6.camel@intel.com>
 <SG2PR03MB187249CC7E902081B5863FC984420@SG2PR03MB1872.apcprd03.prod.outlook.com>
Message-ID: <81718bd6-9aef-cb80-f7c3-79a212f0401b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/19/2017 03:23, Gavin Lambert wrote:
> On 19 October 2017 05:44, quoth Jeff Kirsher:
>> On Tue, 2017-10-17 at 03:05 +0000, Gavin Lambert wrote:
>>> (Please explicitly CC me in any replies.) I have a computer with an
>>> Intel 82571EB 2-port card using the e1000e driver.  I've noticed that
>>> it appears to be dropping some transmitted
>>> packets:
> [...]
>>> What information is needed to diagnose this further and correct the
>>> problem?
>> Any chance you can try the latest stable kernel 4.13.8 or even the latest
>> kernel from Linus's tree (4.14-rc5)?  This will let us know if the issue still
>> persists in the latest upstream kernel or if the issue has been fixed already.
>>
>> Of course, if the issue is fixed in either of the two newer kernels, then you
>> would just need to work with Debian about getting a driver update to thier
>> 4.9 kernel release.
>>
>> I have also added Sasha (e1000e maintainer) to this email thread so that he is
>> aware of the issue and can provide additional assistance in troubleshooting
>> the issue.
> I should be able to try that a little later.  Although it's possibly also worth mentioning that I did try building 3.3.6-NAPI out of tree and the issue persists with that.
>
I believe that will be valuable to try more old kernels too. Also, 
please, open ticket with all details on Source Forge 
(https://sourceforge.net/p/e1000/bugs/?source=navbar), so we will track it.

