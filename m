From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Mon, 6 Jul 2015 17:31:59 +0000
Subject: [Intel-wired-lan] [PATCH V3 0/2] pci: Provide a flag to access
 VPD through function 0
In-Reply-To: <8CB0ECE7-CFE2-43CB-BA60-2E2E0A34D5D1@intel.com>
References: <20150603184445.109080.36387.stgit@mdrustad-wks.jf.intel.com>
 <051B68B4-3E77-4EB0-B9FE-8523631884A2@intel.com>
 <45099CC7-DDAB-41D9-AB74-5A81E2AAF64C@intel.com>
 <CAErSpo7e-QtQQTj2yh_jG07vqU1j1YBez_9wrcrzOQs7+eDFng@mail.gmail.com>
 <8CB0ECE7-CFE2-43CB-BA60-2E2E0A34D5D1@intel.com>
Message-ID: <C468F237-DBA2-4503-BA99-76CC1FC46999@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Jun 26, 2015, at 11:04 AM, Rustad, Mark D <mark.d.rustad@intel.com> wrote:
> 
>> Sorry, Mark, I've just been busy with other issues and haven't had a
>> chance to look at this yet.
> 
> Is there any chance of this getting into this merge window?

Well, it has missed the merge window, but this really is a bug fix. These patches address problems that, under race conditions, can corrupt VPD data and under other conditions can cause hangs. In fact I would submit that the reason that the VPD operations have been made interruptible is directly related to hangs caused by the sharing of VPD capability registers between functions. You see, if one function ever performs a VPD write, any subsequent read on any other function that shares those registers will definitely hang.

I imagine that there are many devices beyond Intel's Ethernet devices that would benefit from using the quirk that these patches introduce.

Please apply it and consider it for -stable.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150706/719cc42f/attachment.asc>
