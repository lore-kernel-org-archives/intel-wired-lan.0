From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 20 May 2015 08:46:33 -0700
Subject: [Intel-wired-lan] [PATCH 3/3] net: igb: register mii_bus for
 SerDes w/ external phy
In-Reply-To: <5555712C.5090106@cumulusnetworks.com>
References: <1430417955-28252-1-git-send-email-tharvey@gateworks.com>
 <1430417955-28252-4-git-send-email-tharvey@gateworks.com>
 <554D5D58.4080300@gmail.com>
 <CAJ+vNU0q+MayxY6taEJNS-vr+jkQAnpVBdb-KisFHYOkNfia-Q@mail.gmail.com>
 <555114B5.9060505@redhat.com>
 <CAJ+vNU1zFXTnaTi2ME7V6C_ucOukDwVTd3_Ne52DOz_0aHyn3A@mail.gmail.com>
 <5555712C.5090106@cumulusnetworks.com>
Message-ID: <CAJ+vNU0NSs+yhgpHWOr5T6H3eanfWcdwEwRBzQ=epiT=zXPPMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, May 14, 2015 at 9:08 PM, Jonathan Toppins
<jtoppins@cumulusnetworks.com> wrote:
> On 5/12/15 6:37 PM, Tim Harvey wrote:
>>
>>
>> agreed - I will separate this into a different patch. I think
>> SIOCGMIIREG/SIOCSMIIREG are useful for debugging and various userspace
>> tools like ethtool and others that allow direct mii register access. I'm
>> not clear what the general consusus is but there do seem to be many
>> ethernet drivers that support SIOCMIIREG including the phylib default
>> ioctl handler.
>
>
> I am on holiday, will get a chance to read over the thread this weekend.
>
> Regards,
> -Jon

Jon,

I will be posting a followup patch very soon (hopefully in the next
couple of days) for adding phylib support to igb hopefully addressing
Alexander's comments and concerns noted in this thread. My phylib phy
driver is an un-posted work-in-progress and because my phy operates
likely different from yours, you will need to write a phylib phy
driver to test the patch when its posted.

Tim
