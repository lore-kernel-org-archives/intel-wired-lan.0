From: Denny Page <dennypage@me.com>
Date: Thu, 22 Dec 2016 10:24:34 -0800
Subject: [Intel-wired-lan] [PATCH v3] ethtool: stop the line wrapping
 madness
In-Reply-To: <AAEA33E297BCAC4B9BB20A7C2DF0AB8D804AC48A@FMSMSX113.amr.corp.intel.com>
References: <20161221003528.4483-1-mitch.a.williams@intel.com>
 <CAKgT0UfAg5aOfi07ZBiHqjCMhGKL9kh-fmUWQSP3L0vfHOTBqw@mail.gmail.com>
 <AAEA33E297BCAC4B9BB20A7C2DF0AB8D804AC48A@FMSMSX113.amr.corp.intel.com>
Message-ID: <F9736926-F45F-4F70-A6B4-2DFE46AE40BF@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I personally found this to be amusing. A little bit of lightheartedness is a good thing. The only serious problem I have with it is that Decwriters are 132 columns wide so I have difficulty viewing this as a justification for an 80 column limit.

Denny


> On Dec 21, 2016, at 09:39, Williams, Mitch A <mitch.a.williams@intel.com> wrote:
> 
>> 
>> On Tue, Dec 20, 2016 at 4:35 PM, Mitch Williams
>> <mitch.a.williams@intel.com> wrote:
>>> Folks, we have a hard limit of 80 characters per line in the kernel,
>>> mostly due to Linus' insistence on printing out each release on greenbar
>>> with his Decwriter. So why do we have function and macro names that are
>>> over 30 characters long? Add a tab or two and a few parameters and boom!
>>> you're wrapping lines.
>> 
>> Get rid of the sarcasm, it comes across as unprofessional.  There are
>> those out there who don't grok it (myself included), and worse yet
>> there are those who will interpret it as being some passive aggressive
>> slight towards Linus.  Best to just leave it out and not have it in
>> there as a reason for the patch to be rejected.  If you need to
>> mention the 80 character limit feel free to quote chunks out of
>> "Documentation/CodingStyle".
> 
> I disagree with you comprehensively. I have been sending out humorous commit messages for years and people (including Dave Miller) have come to expect this from me. Just because you don't get the joke doesn't mean it's unprofessional.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161222/847cbe96/attachment.html>
