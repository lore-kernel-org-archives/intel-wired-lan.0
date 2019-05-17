From: Daniel Walker <danielwa@cisco.com>
Date: Fri, 17 May 2019 11:09:36 -0700
Subject: [Intel-wired-lan] [PATCH] igb: add parameter to ignore nvm
 checksum validation
In-Reply-To: <CAKgT0Ue0b1QxG2ijegbHFz-2Wpxga0ffvhsfDg4VLDRaDSFvdw@mail.gmail.com>
References: <1557357269-9498-1-git-send-email-nkela@cisco.com>
 <9be117dc6e818ab83376cd8e0f79dbfaaf193aa9.camel@intel.com>
 <76B41175-0CEE-466C-91BF-89A1CA857061@cisco.com>
 <4469196a-0705-5459-8aca-3f08e9889d61@gmail.com>
 <20190517010330.2wynopuhsqycqzuq@zorba>
 <bd9e6a93-c8e8-a90e-25b0-26ccbf65b7c4@gmail.com>
 <CAKgT0Uev7sfpOOhusAg9jFLkFeE9JtTntyTd0aAHz2db69L13g@mail.gmail.com>
 <20190517163643.7tlch7xqplxohoq7@zorba>
 <CAKgT0Ue0b1QxG2ijegbHFz-2Wpxga0ffvhsfDg4VLDRaDSFvdw@mail.gmail.com>
Message-ID: <20190517180936.nwsw7brjo2yfvnol@zorba>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, May 17, 2019 at 09:58:46AM -0700, Alexander Duyck wrote:
> > I don't think you can say because the checksum is valid that all data contained
> > inside is also valid. You can have a valid checksum , and someone screwed up the
> > data prior to the checksum getting computed.
> 
> If someone screwed up the data prior to writing the checksum then that
> is on them. In theory we could also have a multi-bit error that could
> similarly be missed. However if the checksum is not valid then the
> data contained in the NVM does not match what was originally written,
> so we know we have bad data. Why should we act on the data if we know
> it is bad?
 
It's hypothetical , but it's likely someone has screwed up the data prior to the
checksum getting computed.

> > > We need to make the checksum a hard stop. If the part is broken then
> > > it needs to be addressed. Workarounds just end up being used and
> > > forgotten, which makes it that much harder to support the product.
> > > Better to mark the part as being broken, and get it fixed now, than to
> > > have parts start shipping that require workarounds in order to
> > > function.o
> >
> > I don't think it's realistic to define the development process for large
> > corporations like Cisco, or like what your doing , to define the development
> > process for all corporations and products which may use intel parts. It's better
> > to be flexible.
> >
> > Daniel
> 
> This isn't about development. If you are doing development you can do
> whatever you want with your own downstream driver. What you are
> attempting to do is update the upstream driver which is used in
> production environments.
 
Cisco has this issue in development, and in production. So your right, it's not
about development in isolation. People make mistakes..

> What concerns me is when this module parameter gets used in a
> development environment and then slips into being required for a
> production environment. At that point it defeats the whole point of
> the checksum in the first place.

I agree .. Ultimately it's the choice of the OEM, if it gets into production
then it's their product and they support the product. As I was saying in a prior
email it should be a priority of the driver to give flexibility for mistakes
people will inevitably make.

Daniel

