From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 2 Feb 2022 16:31:17 +0100
Subject: [Intel-wired-lan] [PATCH net-next] net: kbuild: Don't default
 net vendor configs to y
In-Reply-To: <20220202151707.GA2365@hoboy.vegasvil.org>
References: <30ed8220-e24d-4b40-c7a6-4b09c84f9a1f@gmail.com>
 <20220131121027.4fe3e8dc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <7dc930c6-4ffc-0dd0-8385-d7956e7d16ff@gmail.com>
 <20220131151315.4ec5f2d3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <dd1497ca-b1da-311a-e5fc-7c7265eb3ddf@gmail.com>
 <20220202044603.tuchbk72iujdyxi4@sx1>
 <20220201205818.2f28cfe5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20220202051609.h55eto4rdbfhw5t7@sx1>
 <8566b1e3-2c99-1e63-5606-aad8525a5378@csgroup.eu>
 <20220202064950.qyomo7ns27mbedds@sx1>
 <20220202151707.GA2365@hoboy.vegasvil.org>
Message-ID: <CAK8P3a3ZGFBmxUWm5-DT_QfvU0k8HViEbV4zhwwC8FJLMKZTYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Feb 2, 2022 at 4:17 PM Richard Cochran <richardcochran@gmail.com> wrote:
>
> On Tue, Feb 01, 2022 at 10:49:50PM -0800, Saeed Mahameed wrote:
> > I can't think of a clever easily verifiable way to map boards to their VENDORS.
> > Add to that dispersing the VENDORS configs accurately.
>
> Just an idea...
>
> 1. make foo_defconfig
> 2. for each vendor, do scripts/config --disable vendor
> 3. make savedefconfig
> 4. compare defconfig with foo_defconfig
>    difference means some MAC was removed

This needs an extra 'savedefconfig' step in the beginning, as a lot of
the defconfig
files are already different from what you get after savedefconfig, both in the
order of options, and in options that got renamed or removed over time.

         Arnd
