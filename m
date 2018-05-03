From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 03 May 2018 13:38:35 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] drivers core: multi-threading
 device shutdown
In-Reply-To: <20180503055407.GN3791@eros>
References: <20180503035931.22439-1-pasha.tatashin@oracle.com>
 <20180503035931.22439-3-pasha.tatashin@oracle.com>
 <20180503055407.GN3791@eros>
Message-ID: <CAGM2reYu8uNuasJmsrJ8nzSJ5Zs2466D=ytgG21dJCd+7RO7fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, May 3, 2018 at 1:54 AM Tobin C. Harding <tobin@apporbit.com> wrote:

> This code was a pleasure to read, super clean.


Hi Tobin,

Thank you very much for your review, I will address all of your comments in
the next revision.

BTW, I found  a lock ordering issue in my work that  that I will need to
fix:

In device_shutdown() device_lock() must be taken before
devices_kset->list_lock. Instead I will use device_trylock(), and if that
fails, will drop devices_kset->list_lock and acquiring the device lock
outside, and check that the device is still in the list after taking the
list lock again.

Pavel
