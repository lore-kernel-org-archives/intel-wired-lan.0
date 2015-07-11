From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 11 Jul 2015 14:49:40 -0500
Subject: [Intel-wired-lan] [PATCH V3 0/2] pci: Provide a flag to access
 VPD through function 0
In-Reply-To: <C468F237-DBA2-4503-BA99-76CC1FC46999@intel.com>
References: <20150603184445.109080.36387.stgit@mdrustad-wks.jf.intel.com>
 <051B68B4-3E77-4EB0-B9FE-8523631884A2@intel.com>
 <45099CC7-DDAB-41D9-AB74-5A81E2AAF64C@intel.com>
 <CAErSpo7e-QtQQTj2yh_jG07vqU1j1YBez_9wrcrzOQs7+eDFng@mail.gmail.com>
 <8CB0ECE7-CFE2-43CB-BA60-2E2E0A34D5D1@intel.com>
 <C468F237-DBA2-4503-BA99-76CC1FC46999@intel.com>
Message-ID: <CAErSpo5at=C78JbWEA6YKUNhV4vtUMjSiUKcWG0Ad7Gkg+i2VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jul 6, 2015 at 12:31 PM, Rustad, Mark D <mark.d.rustad@intel.com> wrote:
>> On Jun 26, 2015, at 11:04 AM, Rustad, Mark D <mark.d.rustad@intel.com> wrote:
>>
>>> Sorry, Mark, I've just been busy with other issues and haven't had a
>>> chance to look at this yet.
>>
>> Is there any chance of this getting into this merge window?
>
> Well, it has missed the merge window, but this really is a bug fix. These patches address problems that, under race conditions, can corrupt VPD data and under other conditions can cause hangs. In fact I would submit that the reason that the VPD operations have been made interruptible is directly related to hangs caused by the sharing of VPD capability registers between functions. You see, if one function ever performs a VPD write, any subsequent read on any other function that shares those registers will definitely hang.

As a rule, after the merge window closes, I only merge fixes for
things we broke during the merge window or drivers for brand-new
things, where there's no chance of breaking something that used to
work.

It would be nice to have a description of what a user might see when
tripping over this problem and maybe some pointers to problem reports.
I see it fixes concurrent access problems, and I infer that it's
related to sysfs.

Feel free to add a stable tag when you post your patches.  I'll try to
remember to add it when merging this.  When it's relevant, it's nice
to include the SHA1 of the commit that introduced the bug.  But in
this case, I think it's been there "forever."

Bjorn
