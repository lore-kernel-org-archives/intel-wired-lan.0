From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 22 Jul 2019 16:47:12 +0200
Subject: [Intel-wired-lan] How to update firmware?
In-Reply-To: <9B4A1B1917080E46B64F07F2989DADD69AFF1015@ORSMSX115.amr.corp.intel.com>
References: <f16c92b9-61bf-6ea8-afc9-28e778c2b625@molgen.mpg.de>
 <9B4A1B1917080E46B64F07F2989DADD69AFF0A1B@ORSMSX115.amr.corp.intel.com>
 <14c67f8e-b345-4aae-169f-4b7c9eba5d89@molgen.mpg.de>
 <9B4A1B1917080E46B64F07F2989DADD69AFF1015@ORSMSX115.amr.corp.intel.com>
Message-ID: <ee6faeaf-ba56-d258-726d-e640e8f31e0c@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Todd,


Thank you for your answer.


On 7/22/19 4:34 PM, Fujinaka, Todd wrote:
> If it's a Dell adapter, the answer is you have to ask Dell for
> updates.

Please elaborate, that I can better understand your answer. My
original question is about the *tool* to update the firmware.

Dell provides update binaries, which are a pain to use.

So, let?s hope it?s all a misunderstanding due to email and my
poor language skills, but is Intel interested in making
maintenance easy for the users of their devices?

Unfortunately, today firmware is a thing and requirement due to
complex hardware and consequential bugs, and that most extension
cards are ?full blown computers?. As can be seen with the system
firmware (security mitigations (Spectre, Meltdown, and friends),
device manufacturers (in this case Intel) have a big motivation
to be able to push out firmware updates as fast and convenient
as possible. That is why Microsoft actually pushes board vendors
to support UEFI capsules update method, and GNU/Linux users
profit too.

Hopefully, Intel?s network device can learn from other mistakes,
and will take feedback from the community seriously, and work on
improving the situation. Integration in fwupd/LVFS, or at least
opening up the documentation on how to update firmware on a
device, and publishing even implementations for that would be a
great step into that direction.


Kind regards,

Paul

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190722/6fd060de/attachment.p7s>
