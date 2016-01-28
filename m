From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Thu, 28 Jan 2016 21:08:10 +0000
Subject: [Intel-wired-lan] i210 backplane link (link-mode 1000BASE-KX)
In-Reply-To: <CAJ+vNU3Ntana61AvGy-P7tq0pJt15eK=4rQ6=jiX4NpauTJniQ@mail.gmail.com>
References: <CAJ+vNU1YjyY=BgGPFpMU8wk9hWOKrHXSiffW-HntcNUAubRtDw@mail.gmail.com>
 <9B4A1B1917080E46B64F07F2989DADD65AB28C27@ORSMSX114.amr.corp.intel.com>
 <CAJ+vNU3Ntana61AvGy-P7tq0pJt15eK=4rQ6=jiX4NpauTJniQ@mail.gmail.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD65AB28C76@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I'll go see if I can find where it's stuck in IPS.

However, asking the same question in several venues, especially questions that aren't simple and are outside the normal use of the device, aren't going to get you official answers any quicker.

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565


-----Original Message-----
From: Tim Harvey [mailto:tharvey at gateworks.com] 
Sent: Thursday, January 28, 2016 12:50 PM
To: Fujinaka, Todd
Cc: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T; Marek Va?ut
Subject: Re: [Intel-wired-lan] i210 backplane link (link-mode 1000BASE-KX)

On Thu, Jan 28, 2016 at 12:44 PM, Fujinaka, Todd <todd.fujinaka@intel.com> wrote:
> Can you file this through IPS or through your FAE? I think we should probably have more tracking/focus on this than we can provide through this mailing list.
>

Todd,

I've filed it via IPS as well as our FAE and have waited over a week without any proper response. I figured I would reach out to the community and see if anyone else was using an i210 with 1000BASE-KX and could verify my interconnect and if current igb driver even properly supports this mode.

Ultimately what I am trying to do is interconnect an i210 to a OptixCom BIDI Module (BD9-1250T3R3 DC coupled SerDes to Fiber transceiver). Failing to get anywhere with that I figured I would try something hopefully simpler and just interconnect two i210's and prove out the concept and driver.

Regards,

Tim
