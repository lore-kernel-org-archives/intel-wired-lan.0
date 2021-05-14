From: Edward Cree <ecree.xilinx@gmail.com>
Date: Fri, 14 May 2021 12:08:36 +0100
Subject: [Intel-wired-lan] [PATCH v2 00/40] Use ASCII subset instead of
 UTF-8 alternate symbols
In-Reply-To: <61c286b7afd6c4acf71418feee4eecca2e6c80c8.camel@infradead.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
 <d2fed242fbe200706b8d23a53512f0311d900297.camel@infradead.org>
 <20210514102118.1b71bec3@coco.lan>
 <61c286b7afd6c4acf71418feee4eecca2e6c80c8.camel@infradead.org>
Message-ID: <8b8bc929-2f07-049d-f24c-cb1f1d85bbaa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Fri, 2021-05-14 at 10:21 +0200, Mauro Carvalho Chehab wrote:
>> I do use a lot of UTF-8 here, as I type texts in Portuguese, but I rely
>> on the US-intl keyboard settings, that allow me to type as "'a" for ?.
>> However, there's no shortcut for non-Latin UTF-codes, as far as I know.
>>
>> So, if would need to type a curly comma on the text editors I normally 
>> use for development (vim, nano, kate), I would need to cut-and-paste
>> it from somewhere

For anyone who doesn't know about it: X has this wonderful thing called
 the Compose key[1].  For instance, type ?--- to get ?, or ?<" for ?.
Much more mnemonic than Unicode codepoints; and you can extend it with
 user-defined sequences in your ~/.XCompose file.
(I assume Wayland supports all this too, but don't know the details.)

On 14/05/2021 10:06, David Woodhouse wrote:
> Again, if you want to make specific fixes like removing non-breaking
> spaces and byte order marks, with specific reasons, then those make
> sense. But it's got very little to do with UTF-8 and how easy it is to
> type them. And the excuse you've put in the commit comment for your
> patches is utterly bogus.

+1

-ed

[1] https://en.wikipedia.org/wiki/Compose_key
