From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 5 Jun 2015 08:08:08 -0700
Subject: [Intel-wired-lan] [PATCH 3/3] net: igb: register mii_bus for
 SerDes w/ external phy
In-Reply-To: <55688521.5030802@cumulusnetworks.com>
References: <1430417955-28252-1-git-send-email-tharvey@gateworks.com>
 <1430417955-28252-4-git-send-email-tharvey@gateworks.com>
 <554D5D58.4080300@gmail.com>
 <CAJ+vNU0q+MayxY6taEJNS-vr+jkQAnpVBdb-KisFHYOkNfia-Q@mail.gmail.com>
 <555114B5.9060505@redhat.com>
 <CAJ+vNU1zFXTnaTi2ME7V6C_ucOukDwVTd3_Ne52DOz_0aHyn3A@mail.gmail.com>
 <5555712C.5090106@cumulusnetworks.com>
 <CAJ+vNU0NSs+yhgpHWOr5T6H3eanfWcdwEwRBzQ=epiT=zXPPMA@mail.gmail.com>
 <55688521.5030802@cumulusnetworks.com>
Message-ID: <CAJ+vNU2D+Y9FoYU0cYbbMM638K9W-oaY-24p1_zZ3GnrPD9AzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, May 29, 2015 at 8:26 AM, Jonathan Toppins
<jtoppins@cumulusnetworks.com> wrote:
> On 5/20/15 11:46 AM, Tim Harvey wrote:
<snip>
>
> Thanks for the update Tim. I have not had time to look at this for now but
> also have not seen your v2 series either, did I miss that?
>
> -Jon

Jon,

You haven't missed it - I've gotten pulled off onto some other things
and haven't gotten back to it. Where it stands right now I have a
patch that should be completely 'safe' and eliminate any backwards
compatibility concerns however I'm not convinced I'm skipping enough
phy related code when phylib mode is used. Arguably those could come
later as issues are found with phylib phy drivers, but I feel like if
I can just get another half day into it I could possibly work out
those issues as well.

Tim
