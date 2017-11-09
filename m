From: Matt Turner <mattst88@gmail.com>
Date: Thu, 9 Nov 2017 13:40:42 -0800
Subject: [Intel-wired-lan] [PATCH 3/3] e1000e: Disable jumbo receive
 workaround on Lynx Point and newer
In-Reply-To: <7c28a53a-0e23-e211-05ba-0a1891f8e9c5@intel.com>
References: <20171107221332.28283-1-mattst88@gmail.com>
 <20171107221332.28283-3-mattst88@gmail.com>
 <7c28a53a-0e23-e211-05ba-0a1891f8e9c5@intel.com>
Message-ID: <CAEdQ38Fc1mSzXcN8KTjUMBRWsdPpj5K_ZWcBHDri7P4w+9B-JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Nov 9, 2017 at 12:19 AM, Neftin, Sasha <sasha.neftin@intel.com> wrote:
> This patch should be rejected. The original patch 3e35d9918cbb ("e1000e:
> adjust PM QoS request") is from 2013, before Lynx Point and later devices
> were introduced. However, nothing was changed in this regard in the later
> devices and same limitation still apply.

Dang, that's unfortunate. Thanks for checking.
