<?php

namespace App\UseCase;

use App\Repositories\NotificationRepository;

class UserNotificationsUseCase
{

    /**
     * @var NotificationRepository
     */
    private $notificationsRepository;

    /**
     * UserNotificationsUseCase constructor.
     *
     * @param NotificationRepository $notificationsRepository
     */
    public function __construct(NotificationRepository $notificationsRepository)
    {
        $this->notificationsRepository = $notificationsRepository;
    }


    public function getUserNotifications($userId)
    {
        return $this->notificationsRepository->findByUserId($userId);
    }
}